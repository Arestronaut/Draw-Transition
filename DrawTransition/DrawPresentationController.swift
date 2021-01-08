import UIKit

/// The `UIPresentationController` used for the draw transition
public final class DrawerPresentationController: UIPresentationController {
    // MARK: - Properties
    private var model: DrawerPresentationControllerViewModel = .default

    private var currentSnapPoint: DrawerSnapPoint = .origin {
        didSet {
            currentSnapPointDidChange()
        }
    }

    private lazy var panGesture: UIPanGestureRecognizer = .init(target: self, action: #selector(didTriggerPanGesture(gestureRecognizer:)))

    private lazy var drawerContainerView: DrawerContainerView = .init()

    // MARK: - Initialization
    /// The convenience initializer for `DrawerPresentationController`
    ///
    /// - Parameter presentedViewController: The `UIViewController` that is presented
    /// - Parameter presentingViewController: The initial `UIViewController`
    /// - Parameter model: The `DrawerPresentationControllerViewModel` used to setup the transition
    public convenience init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?,
        model: DrawerPresentationControllerViewModel = .default
    ) {
        self.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.model = model
    }

    // MARK: - Methods
    public override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()

        presentedView?.frame.origin = .init(x: 0.0, y: UIScreen.main.bounds.height * model.originHeightPercentage)
    }

    public override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        presentedView?.layer.borderColor = UIColor.systemGray2.cgColor
        presentedView?.layer.borderWidth = model.borderWidth
        presentedView?.layer.cornerRadius = model.cornerRadius
        presentedView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        presentedView?.addGestureRecognizer(self.panGesture)

        drawerContainerView.delegate = self
        drawerContainerView.backgroundColor = .clear
        drawerContainerView.frame = containerView?.superview?.frame ?? .zero
        drawerContainerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        if let containerView = self.containerView {
            containerView.superview?.addSubview(drawerContainerView)
            drawerContainerView.addSubview(containerView)
        }
    }

    public override func dismissalTransitionDidEnd(_ completed: Bool) {
        drawerContainerView.removeFromSuperview()
    }

    private func sendToTop() {
        let yOffset = presentingViewController.view.center.y
        presentedView?.layer.borderWidth = 0.0

        UIView.animate(withDuration: model.animationDuration) { [weak self] in
            self?.presentedView?.center.y = yOffset
        }
    }

    private func sendToOrigin() {
        UIView.animate(withDuration: model.animationDuration) { [weak self] in
            guard let self = self else { return }
            self.presentedView?.frame.origin.y = UIScreen.main.bounds.height * self.model.originHeightPercentage
        }
    }

    private func dismiss() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }

    private func currentSnapPointDidChange() {
        model.onSnapPointChanged(currentSnapPoint)

        switch currentSnapPoint {
        case .top:
            sendToTop()

        case .origin:
            sendToOrigin()

        case .close:
            dismiss()
        }
    }

    @objc
    private func didTriggerPanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        guard let presentedView = self.presentedView else { return }

        guard currentSnapPoint != .top else { return }

        switch gestureRecognizer.state {
        case .changed:
            let translation = gestureRecognizer.translation(in: presentingViewController.view)
            let yOffset = presentedView.center.y + translation.y

            presentedView.center.y = yOffset
            gestureRecognizer.setTranslation(CGPoint.zero, in: presentingViewController.view)

        case .ended:
            let height = presentingViewController.view.frame.height
            let position = presentedView.convert(presentingViewController.view.frame, to: nil).origin.y

            if position < (model.snapToTopPercentage * height) {
                self.currentSnapPoint = .top
            } else if (model.snapToTopPercentage * height) ..< (model.snapToOriginPercentage * height) ~= position {
                self.currentSnapPoint = .origin
            } else {
                currentSnapPoint = .close
            }

            gestureRecognizer.setTranslation(CGPoint.zero, in: presentingViewController.view)

        default:
            return
        }
    }
}

extension DrawerPresentationController: DrawerContainerViewDelegate {
    internal func view(_ view: DrawerContainerView, shouldPassthroughTouchAt point: CGPoint) -> Bool {
        guard let presentedView = presentedView else { return false }
        return !presentedView.bounds.contains(presentedView.convert(point, from: view))
    }

    internal func view(_ view: DrawerContainerView, forTouchAt point: CGPoint) -> UIView? {
        guard case DrawerSnapPoint.origin = currentSnapPoint else { return containerView }
        return presentedView
    }
}

