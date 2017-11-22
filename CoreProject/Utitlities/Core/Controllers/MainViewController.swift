import UIKit

enum TabBarType: Int {
    case information = 0
    case chat
    case timeline
    case plan
}

class TTabBarItem: UITabBarItem {
    var type: TabBarType?
}

class MainViewController: UITabBarController {

    // MARK: - Varialbes

    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()

        // setup
        self.setupStartTabbar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Setup View
    func hideTabbar(hide: Bool?, animated: Bool = false) {
        self.tabBar.isHidden = hide ?? false
    }

    // MARK: - Actions

    // MARK: - Call Api

    // MARK: - Functions
    func setupStartTabbar() {

        // Infomation
        let navigationStart = StartViewController.fromStoryboard(Storyboard.Main.name)
        let tabBarItemStart = TTabBarItem(title: "Start", image: #imageLiteral(resourceName: "ic_tabbar_infor"), selectedImage: #imageLiteral(resourceName: "ic_tabbar_infor"))
        navigationStart.tabBarItem = tabBarItemStart

        // set list childs controller to tabbar
        let controllers = [navigationStart]
        viewControllers = controllers
        hideTabbar(hide: true)
    }

    func setupMainTabbar() {

        // Infomation
        let navigationInfor = UIStoryboard(name: Storyboard.Information.name, bundle: nil).instantiateInitialViewController()!
        let tabBarItemInfor = TTabBarItem(title: "Information", image: #imageLiteral(resourceName: "ic_tabbar_infor"), selectedImage: #imageLiteral(resourceName: "ic_tabbar_infor"))
        tabBarItemInfor.type = .information
        navigationInfor.tabBarItem = tabBarItemInfor

        // Chat
        let navigationChat = UIStoryboard(name: Storyboard.Chat.name, bundle: nil).instantiateInitialViewController()!
        let tabBarItemChat = TTabBarItem(title: "Chat", image: #imageLiteral(resourceName: "ic_tabbar_chat"), selectedImage: #imageLiteral(resourceName: "ic_tabbar_chat"))
        tabBarItemChat.type = .chat
        navigationChat.tabBarItem = tabBarItemChat

        // Timeline
        let navigationTimeline = UIStoryboard(name: Storyboard.Timeline.name, bundle: nil).instantiateInitialViewController()!
        let tabBarItemTimeline = TTabBarItem(title: "Timeline", image: #imageLiteral(resourceName: "ic_tabbar_timeline"), selectedImage: #imageLiteral(resourceName: "ic_tabbar_timeline"))
        tabBarItemTimeline.type = .timeline
        navigationTimeline.tabBarItem = tabBarItemTimeline

        // Plan
        let navigationPlan = UIStoryboard(name: Storyboard.Plan.name, bundle: nil).instantiateInitialViewController()!
        let tabBarItemPlan = TTabBarItem(title: "Plan", image: #imageLiteral(resourceName: "ic_tabbar_plan"), selectedImage: #imageLiteral(resourceName: "ic_tabbar_plan"))
        tabBarItemPlan.type = .plan
        navigationPlan.tabBarItem = tabBarItemPlan

        // set list childs controller to tabbar
        let controllers = [navigationInfor, navigationChat, navigationTimeline, navigationPlan]
        viewControllers = controllers
        hideTabbar(hide: false)
    }

    func gotoChatTab(object: AnyObject?) {
        self.selectedIndex = TabBarType.chat.rawValue
    }
}
