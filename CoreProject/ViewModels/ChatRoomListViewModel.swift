//
//  ChatRoomListViewModel.swift
//  CoreProject
//
//  Created by Henry Tran on 11/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

public protocol ViewModel {}
public typealias CellModelInfo = (viewModel: ViewModel?, height: CGFloat)

class ChatRoomListViewModel: ViewModel {

    // MARK: - Callback
    var reloadTableViewCallback: ((Bool?) -> Void)?

    // MARK: - Variables
    fileprivate var listChatRoom: [ChatRoom]
    fileprivate var listCells: [CellModelInfo]

    // MARK: - Init
    init() {
        listChatRoom = []
        listCells = []
    }

    // MARK: - Actions

    // MARK: - Api
    func doGetListChatRoom() {

        for _ in 0...20 {

            // data
            let chatRoom = ChatRoom()
            listChatRoom.append(chatRoom)

            // cache height cell
            let viewModel = cellModelInfo(of: chatRoom, at: IndexPath(item: listCells.count, section: 0))
            listCells.append(viewModel)
        }

        // reload
        reloadTableViewCallback?(true)

    }

    // MARK: - Functions
    fileprivate func cellModelInfo(of chatRoom: ChatRoom?, at indexPath: IndexPath?) -> CellModelInfo {
        let viewModel = cellViewModel(of: chatRoom, at: indexPath)
        let heightCell = estimateHeightCell(of: viewModel, at: indexPath)

        return (viewModel, heightCell)
    }

    fileprivate func cellViewModel(of chatRoom: ChatRoom?, at indexPath: IndexPath?) -> ViewModel? {
        var chatRoomCellViewModel = ChatRoomCellViewModel()
        if (indexPath?.row ?? 0) % 4 == 0 {
            chatRoomCellViewModel.chatRoomName = "chachatRoomNamechatRoomNamechatRoomNamechatRoomNamechatRoomNamechatRoomNamechatRoomNametRoomName"
            chatRoomCellViewModel.chatRoomDescpription = "chatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptichatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpription1212chatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpription12121244412444on1212chatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpription12121244412444"
        } else if (indexPath?.row ?? 0) % 4 == 1 {
            chatRoomCellViewModel.chatRoomName = "chachatRoom"
            chatRoomCellViewModel.chatRoomDescpription = "chatRoomDescpription"
        } else {
            chatRoomCellViewModel.chatRoomName = "chatRoomName"
            chatRoomCellViewModel.chatRoomDescpription = "chatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpription1212chatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpriptionchatRoomDescpription12121244412444"
        }

        return chatRoomCellViewModel
    }

    fileprivate func estimateHeightCell(of viewModel: ViewModel?, at indexPath: IndexPath?) -> CGFloat {

        var heightCell: CGFloat = 0

        if let chatRoomCellViewModel = viewModel as? ChatRoomCellViewModel {

            let screenWidth = Device.screenWidth
            let maxWidth = screenWidth - 10 - 80 - 10 - 10
            let attributesName = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)]

            if let size = chatRoomCellViewModel.chatRoomName?.sizeToFitWidth(maxWidth, attributes: attributesName) {
                heightCell += 10
                heightCell += size.height
            }

            let attributesDescription =  [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
            if let size = chatRoomCellViewModel.chatRoomDescpription?.sizeToFitWidth(maxWidth, attributes: attributesDescription) {
                heightCell += 10
                heightCell += size.height
            }

            heightCell += 10
        }

        if heightCell < 100.0 {
            return 100.0
        }

        return heightCell
    }

    func numberOfRows(in section: Int) -> Int {
        return listCells.count
    }

    func heightCell(at indexPath: IndexPath) -> CGFloat {
        return listCells[indexPath.row].height
    }

    func cellViewModel(at indexPath: IndexPath ) -> ViewModel? {
        return listCells[indexPath.row].viewModel
    }

    // MARK: - Call Api

}
