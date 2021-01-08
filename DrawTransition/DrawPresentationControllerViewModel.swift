import UIKit

public enum DrawerSnapPoint {
    case top
    case origin
    case close
}

public struct DrawerPresentationControllerViewModel {
    public typealias OnSnapPointChangedCallback = (DrawerSnapPoint) -> Void

    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    public let borderColor: UIColor
    public let centerYOffset: CGFloat
    public let snapToTopPercentage: CGFloat
    public let snapToOriginPercentage: CGFloat
    public let animationDuration: Double
    public let onSnapPointChanged: OnSnapPointChangedCallback

    public init(
        cornerRadius: CGFloat = Self.default.cornerRadius,
        borderWidth: CGFloat = Self.default.borderWidth,
        borderColor: UIColor = Self.default.borderColor,
        centerYOffset: CGFloat = Self.default.centerYOffset,
        snapToTopPercentage: CGFloat = Self.default.snapToTopPercentage,
        snapToOriginPercentage: CGFloat = Self.default.snapToOriginPercentage,
        animationDuration: Double = Self.default.animationDuration,
        onSnapPointChanged: @escaping OnSnapPointChangedCallback = Self.default.onSnapPointChanged
    ) {
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.centerYOffset = centerYOffset
        self.snapToTopPercentage = snapToTopPercentage
        self.snapToOriginPercentage = snapToOriginPercentage
        self.animationDuration = animationDuration
        self.onSnapPointChanged = onSnapPointChanged
    }
}

extension DrawerPresentationControllerViewModel {
    public static let `default`: DrawerPresentationControllerViewModel = .init(
        cornerRadius: 20.0,
        borderWidth: 1.5,
        borderColor: .lightGray,
        centerYOffset: 200.0,
        snapToTopPercentage: 0.7,
        snapToOriginPercentage: 0.85,
        animationDuration: 0.2,
        onSnapPointChanged: { _ in }
    )
}
