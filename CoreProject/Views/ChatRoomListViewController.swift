//
//  ChatRoomListViewController.swift
//  CoreProject
//
//  Created by Henry Tran on 11/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ChatRoomListViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet fileprivate weak var tableView: UITableView!

    // MARK: - Variables
    var viewModel: ChatRoomListViewModel?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.doGetListChatRoom()
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
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        // register Cell
        ChatRoomTableViewCell.registerNibIn(tableView)

    }

    fileprivate func setupViewModel() {

        // init
        viewModel = ChatRoomListViewModel()

        // reload
        viewModel?.reloadTableViewCallback = { [weak self] (animated) in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

    }

    // MARK: - Actions

    // MARK: - Functions

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ChatRoomListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(in: section) ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.heightCell(at: indexPath) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // dequeue cell
        let cell: ChatRoomTableViewCell = ChatRoomTableViewCell.dequeueReusableCellFrom(tableView, indexPath: indexPath)

        // binding data
        let cellModel = viewModel?.cellViewModel(at: indexPath)
        cell.config(viewModel: cellModel)

        // return
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
    }

}
