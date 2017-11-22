import UIKit

// MARK: UIViewController
extension UIViewController {

    static func fromStoryboard(_ storyboardName: String) -> UIViewController {
        let identifier = String(describing: self)
        return UIViewController.withIdentifier(identifier, storyboardName: storyboardName)
    }

    static func withIdentifier(_ identifier: String, storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
