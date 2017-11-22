//
//  TraineeInforViewController.swift
//  ToeicCoach
//
//  Created by Henry Tran on 10/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class TraineeInfoChildViewController: BaseViewController {
    weak var parentContainerViewController: UIViewController?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.delegateSwipeBack(of: parentContainerViewController?.mainViewController, to: self)
        self.enableSwipeBack(enable: true, for: parentContainerViewController?.mainViewController)
    }

}

enum TraineeSegment: Int {
    case situation = 0
    case registration
}

class TraineeInforViewController: BaseViewController {

    private lazy var pageViewController: UIPageViewController? = {
        return self.childViewControllers.first as? UIPageViewController
    }()

    private lazy var traineeSituationInforViewController: UIViewController? = {
        let viewController = TraineeSituationInforViewController.fromStoryboard(Storyboard.Information.name) as? TraineeInfoChildViewController
        viewController?.parentContainerViewController = self
        return viewController
    }()

    private lazy var traineeRegistrationInforViewController: UIViewController? = {
        let viewController = TraineeRegistrationInforViewController.fromStoryboard(Storyboard.Information.name) as? TraineeInfoChildViewController
        viewController?.parentContainerViewController = self
        return viewController
    }()

    // MARK: - IBOutlet
    @IBOutlet private weak var situationButton: UIButton!
    @IBOutlet private weak var registrationButton: UIButton!

    // MARK: - Varialbes
    var currentSegment: TraineeSegment?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.showSituationInforViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setNavTitle(title: "Information", subtitle: nil)
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

    // MARK: - Call Api

    // MARK: - Actions
    @IBAction func touchButtonSituationInfoAction(_ sender: Any) {
        if self.currentSegment != .situation {
            self.showSituationInforViewController()
        }
    }

    @IBAction func touchButtonRegistrationInfoAction(_ sender: Any) {
        if self.currentSegment != .registration {
            self.showRegistrationInforViewController()
        }
    }

    // MARK: - Functions
    private func showSituationInforViewController() {
        if let viewController = self.traineeSituationInforViewController {
            self.registrationButton.isHighlighted = true
            self.currentSegment = .situation
            self.pageViewController?.setViewControllers([viewController], direction: .forward, animated: false, completion: nil)
        }
    }

    private func showRegistrationInforViewController() {
        if let viewController = self.traineeRegistrationInforViewController {
            self.situationButton.isHighlighted = true
            self.currentSegment = .registration
            self.pageViewController?.setViewControllers([viewController], direction: .reverse, animated: false, completion: nil)
        }}
}
