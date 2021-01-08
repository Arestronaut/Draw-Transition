import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction
    private func startTransitionButtonAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let viewController = storyboard.instantiateViewController(identifier: "SecondViewController") as? SecondViewController
        else { return }


        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .custom
        navigationController.transitioningDelegate = viewController

        present(navigationController, animated: true, completion: nil)
    }
}

