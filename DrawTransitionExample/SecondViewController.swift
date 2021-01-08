import DrawTransition
import UIKit

final class SecondViewController: UIViewController {
}

extension SecondViewController: UIViewControllerTransitioningDelegate {
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        let model = DrawerPresentationControllerViewModel(centerYOffset: 0.0, snapToTopPercentage: 0.6)

        return DrawerPresentationController(presentedViewController: presented, presenting: presenting, model: model)
    }
}
