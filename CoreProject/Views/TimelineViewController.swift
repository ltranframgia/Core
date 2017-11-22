//
//  TimelineViewController.swift
//  ToeicCoach
//
//  Created by Henry Tran on 10/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class TimelineViewController: BaseViewController {

    // MARK: - IBOutlet

    // MARK: - Varialbes

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setNavTitle(title: "Timeline", subtitle: nil)
        self.showLoadingIndicator(inView: self.view, position: .center, offset: 0)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let btn = XButton(type: UIButtonType.system)
        btn.isCustomHighlight = true
        btn.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        btn.setTitle("Error", for: UIControlState.normal)
        btn.setTitleColor(UIColor.red, for: UIControlState.normal)
        btn.backgroundColor = UIColor.white
        let errorView = ErrorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        errorView.backgroundColor = UIColor.green
        errorView.alpha = 0.6
        errorView.addSubview(btn)

        self.showError(errorView: errorView, inView: self.view)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    // MARK: - Setup View

    // MARK: - Call Api

    // MARK: - Actions

    // MARK: - Functions

}
