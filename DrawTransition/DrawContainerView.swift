import UIKit

public protocol DrawerContainerViewDelegate: AnyObject {
    func view(_ view: DrawerContainerView, shouldPassthroughTouchAt point: CGPoint) -> Bool
    func view(_ view: DrawerContainerView, forTouchAt point: CGPoint) -> UIView?
}

public final class DrawerContainerView: UIView {
    weak var delegate: DrawerContainerViewDelegate?

    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard
            let delegate = self.delegate,
            delegate.view(self, shouldPassthroughTouchAt: point),
            let touchView = delegate.view(self, forTouchAt: point)
        else {
            return super.hitTest(point, with: event)
        }

        let viewPoint = touchView.convert(point, from: self)
        return touchView.hitTest(viewPoint, with: event)
    }
}
