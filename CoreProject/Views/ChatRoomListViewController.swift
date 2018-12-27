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
    var viewModel: TableViewModelBindable?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel?.doGetData(.center)
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

        // tableView
        tableView.delegate = self
        tableView.dataSource = self

        // register Cell
        ChatRoomTableViewCell.registerNibIn(tableView)

    }

    fileprivate func setupViewModel() {

        // init
        if viewModel == nil {
            viewModel = ChatRoomListViewModel()
        }

        // loading
        viewModel?.loading.onUpdate = { [weak self] (loading) in
            DispatchQueue.main.async {
                if loading?.show == false {
                    self?.hideLoadingIndicator()
                    self?.tableView.hideLoadMoreFooterView()
                } else {

                    if loading?.type == .center {
                        self?.showLoadingIndicator(inView: self?.tableView, position: .center, offset: 0)
                    }
                }
            }
        }

        // reload
        viewModel?.tableView.reloadData.onUpdate = { [weak self] (animated) in
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
        self.performSegue(withIdentifier: "gotoChat", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        // load more
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        let maximumOffset = contentHeight - frameHeight
        if maximumOffset - contentOffsetY <= 50 {
            if self.viewModel?.isRequesting != true {
                tableView.showLoadMoreFooterView {
                    self.viewModel?.doGetData(.loadMore)
                }
            }
        }
    }

}
