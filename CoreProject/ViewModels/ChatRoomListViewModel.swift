//
//  ChatRoomListViewModel.swift
//  CoreProject
//
//  Created by Henry Tran on 11/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ChatRoomListViewModel: ViewModelComfortable {

    // MARK: - Callback
    var tableView: TableViewDynamic = TableViewDynamic()
    var updateLoadingStatusCallback: ((Bool, LoadingType?) -> Void)?

    // MARK: - Variables
    fileprivate var listChatRoom: [ChatRoom]
    fileprivate var listCells: [CellModelInfo]
    var isLoading: Bool?

    // MARK: - Init
    init() {
        listChatRoom = []
        listCells = []
    }

    // MARK: - Actions

    // MARK: - Api
    func doGetListChatRoom(_ loadingType: LoadingType?) {
        updateLoadingStatusCallback?(false, loadingType)
        isLoading = true
        DispatchQueue.global(qos: .background).async {

            for _ in 0..<20 {

                // data
                let chatRoom = ChatRoom()
                self.listChatRoom.append(chatRoom)

                // cache height cell
                let indexPath = IndexPath(item: self.listCells.count, section: 0)
                let viewModel = self.cellModelInfo(of: chatRoom, at: indexPath)
                self.listCells.append(viewModel)
            }

            // reload
            DispatchQueue.main.async {
                self.updateLoadingStatusCallback?(true, loadingType)
                self.tableView.reloadData.value = true
                self.isLoading = false
            }
        }
    }

    // MARK: - Functions
    fileprivate func cellModelInfo(of chatRoom: ChatRoom?, at indexPath: IndexPath?) -> CellModelInfo {
        let viewModel = createCellViewModel(of: chatRoom, at: indexPath)
        let heightCell = estimateCellHeight(of: viewModel, at: indexPath)

        return (viewModel, heightCell)
    }

    fileprivate func createCellViewModel(of chatRoom: ChatRoom?, at indexPath: IndexPath?) -> ViewModelComfortable? {
        let row = indexPath?.row ?? 0
        var chatRoomCellViewModel = ChatRoomCellViewModel()
        if row % 4 == 0 {
            chatRoomCellViewModel.chatRoomName = "chachchachatRoomNamechachatRoomNamechachatRoomNamechachatRoomNameatRoomName + \(row)"
            chatRoomCellViewModel.chatRoomDescpription = "chatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptichatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpription1212chatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpription12121244412444on1212chatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpription12121244412444"
        } else if row % 4 == 1 {
            chatRoomCellViewModel.chatRoomName = "chachatRoomName + \(row)"
            chatRoomCellViewModel.chatRoomDescpription = "chatRoomDescpription"
        } else {
            chatRoomCellViewModel.chatRoomName = chatRoom?.chatRoomName
            chatRoomCellViewModel.chatRoomDescpription = chatRoom?.chatRoomDescpription
        }

        return chatRoomCellViewModel
    }

    fileprivate func estimateCellHeight(of viewModel: ViewModelComfortable?, at indexPath: IndexPath?) -> CGFloat {

        let heightCell: CGFloat =  (viewModel as? ChatRoomCellViewModel)?.estimateCellHeight(at: indexPath) ?? 0
        return heightCell
    }

    // MARK: - Data Sources
    func numberOfRows(in section: Int) -> Int {
        return listCells.count
    }

    func heightCell(at indexPath: IndexPath) -> CGFloat {
        return listCells[indexPath.row].height
    }

    func cellViewModel(at indexPath: IndexPath ) -> ViewModelComfortable? {
        return listCells[indexPath.row].viewModel
    }

}
