import UIKit

class StartViewController: BaseViewController {

    // MARK: - IBOutlet

    // MARK: - Varialbes

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // check app
        self.checkApp()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Setup View

    // MARK: - Actions

    // MARK: - Call Api

    // MARK: - Functions
    private func checkApp() {

        // User module (login, register, ...)
        self.perform(#selector(StartViewController.gotoLoginView), with: nil, afterDelay: 1)

        // List trainee
        //self.perform(#selector(StartViewController.gotoMainApp), with: nil, afterDelay: 1)
    }

    @objc func gotoLoginView() {
        let navigationVC  = UIStoryboard(name: Storyboard.Account.name, bundle: nil).instantiateInitialViewController()!

        // present
        self.present(navigationVC, animated: false, completion: nil)
    }

    @objc func gotoMainApp() {
//        self.rootMenuViewController?.gotoHomeView()
    }
}
