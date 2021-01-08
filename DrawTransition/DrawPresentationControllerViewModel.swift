import UIKit

/// Enumeration of all snap points
public enum DrawerSnapPoint {
    case top
    case origin
    case close
}

/// The ViewModel containing all the transition parameters
public struct DrawerPresentationControllerViewModel {
    public typealias OnSnapPointChangedCallback = (DrawerSnapPoint) -> Void

    /// The corner radius of the preview view
    public let cornerRadius: CGFloat

    /// The border width of the preview
    public let borderWidth: CGFloat

    /// The border color of the preview
    public let borderColor: UIColor

    /// The height percentage (in relation to the screen height) of the origin
    public let originHeightPercentage: CGFloat

    /// The percentage from which the view will snap to the top
    public let snapToTopPercentage: CGFloat

    /// The percentage from which the view will snap back to its origin
    public let snapToOriginPercentage: CGFloat

    /// The animation duration
    public let animationDuration: Double

    /// The closure called when the snap point changed
    public let onSnapPointChanged: OnSnapPointChangedCallback

    /// Initializer for `DrawerPresentationControllerViewModel`
    public init(
        cornerRadius: CGFloat = Self.default.cornerRadius,
        borderWidth: CGFloat = Self.default.borderWidth,
        borderColor: UIColor = Self.default.borderColor,
        originHeightPercentage: CGFloat = Self.default.originHeightPercentage,
        snapToTopPercentage: CGFloat = Self.default.snapToTopPercentage,
        snapToOriginPercentage: CGFloat = Self.default.snapToOriginPercentage,
        animationDuration: Double = Self.default.animationDuration,
        onSnapPointChanged: @escaping OnSnapPointChangedCallback = Self.default.onSnapPointChanged
    ) {
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.originHeightPercentage = originHeightPercentage
        self.snapToTopPercentage = snapToTopPercentage
        self.snapToOriginPercentage = snapToOriginPercentage
        self.animationDuration = animationDuration
        self.onSnapPointChanged = onSnapPointChanged
    }
}

extension DrawerPresentationControllerViewModel {
    /// Default initializer for `DrawerPresentationControllerViewModel`
    public static let `default`: DrawerPresentationControllerViewModel = .init(
        cornerRadius: 20.0,
        borderWidth: 1.5,
        borderColor: .lightGray,
        originHeightPercentage: 0.7,
        snapToTopPercentage: 0.7,
        snapToOriginPercentage: 0.85,
        animationDuration: 0.2,
        onSnapPointChanged: { _ in }
    )
}
