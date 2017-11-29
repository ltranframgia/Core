//
//  ChatRoomTableViewCell.swift
//  CoreProject
//
//  Created by Henry Tran on 11/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ChatRoomTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet fileprivate weak var chatRoomAvatarImageView: UIImageView!
    @IBOutlet fileprivate weak var chatRoomNameLabel: UILabel!
    @IBOutlet fileprivate weak var chatRoomDescriptionLabel: UILabel!

    static let height: CGFloat = 100.0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Setup
    func config(viewModel: ViewModelComfortable?) {
        if let chatRoomCellViewModel = viewModel as? ChatRoomCellViewModel {
            self.config(chatRoomCellViewModel: chatRoomCellViewModel)
        }

    }

    fileprivate func config(chatRoomCellViewModel: ChatRoomCellViewModel?) {
        chatRoomNameLabel.text = chatRoomCellViewModel?.chatRoomName
        chatRoomDescriptionLabel.text = chatRoomCellViewModel?.chatRoomDescpription
    }

}

struct ChatRoomCellViewModel: ViewModelComfortable {

    var chatRoomName: String?
    var chatRoomDescpription: String?
    var chatRoomAvatarUrl: String?

    // MARK: - Functions
    func estimateCellHeight(at indexPath: IndexPath?) -> CGFloat {

        var heightCell: CGFloat = 0
        let screenWidth = Device.screenWidth
        let maxWidth = screenWidth - 10 - 80 - 10 - 10
        let attributesName = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)]

        if let size = chatRoomName?.sizeToFitWidth(maxWidth, attributes: attributesName) {
            heightCell += 10
            heightCell += size.height
        }

        let attributesDescription =  [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        if let size = chatRoomDescpription?.sizeToFitWidth(maxWidth, attributes: attributesDescription) {
            heightCell += 10
            heightCell += size.height
        }

        heightCell += 10

        // validate
        if heightCell < ChatRoomTableViewCell.height {
            return ChatRoomTableViewCell.height
        }

        // return
        return heightCell
    }

}
