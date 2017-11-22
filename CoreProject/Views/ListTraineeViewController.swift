//
//  ListTraineeViewController.swift
//  ToeicCoach
//
//  Created by Henry Tran on 10/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ListTraineeViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Varialbes

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.showLoadingIndicator(inView: self.tableView, position: .center, offset: -26)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Setup View
    private func initView() {

        self.setNavTitle(title: "List Trainee", subtitle: nil)

        // TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        TraineeTableViewCell.registerNibIn(self.tableView)
    }

    // MARK: - Call Api

    // MARK: - Actions

    // MARK: - Functions
    fileprivate func gotoInfoView() {
        if let tabbarVC = MainViewController.fromStoryboard(Storyboard.Home.name) as? MainViewController {
            self.navigationController?.pushViewController(tabbarVC, animated: true)

        }
    }

    fileprivate func gotoChatView() {
        if let tabbarVC = MainViewController.fromStoryboard(Storyboard.Home.name) as? MainViewController {
            tabbarVC.gotoChatTab(object: nil)
            self.navigationController?.pushViewController(tabbarVC, animated: true)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ListTraineeViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 120
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TraineeTableViewCell.height
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // dequeue cell
        if let cell = TraineeTableViewCell.dequeueReusableCellFrom(tableView, indexPath: indexPath) as? TraineeTableViewCell {
            cell.delegate = self

            // return
            return cell
        }

        return UITableViewCell(style: .default, reuseIdentifier: nil)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.hideLoadingIndicator()
        self.gotoInfoView()

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - TableViewCellTraineeDelegate
extension ListTraineeViewController: TableViewCellTraineeDelegate {
    func tableViewCell(tableViewCell: UITableViewCell, touchChatButtonAtIndexPath: IndexPath?) {
        self.gotoChatView()
    }
}
