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
        DrawerPresentationController(presentedViewController: presented, presenting: presenting, model: .default)
    }
}
