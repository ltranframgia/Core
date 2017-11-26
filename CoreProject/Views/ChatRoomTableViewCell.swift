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

    static var height: CGFloat = 44.0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(viewModel: ViewModel?) {
        guard let chatRoomCellViewModel = viewModel as? ChatRoomCellViewModel else {
            return
        }

        chatRoomNameLabel.text = chatRoomCellViewModel.chatRoomName
        chatRoomDescriptionLabel.text = chatRoomCellViewModel.chatRoomDescpription

    }
}

struct ChatRoomCellViewModel: ViewModel {
    var chatRoomName: String?
    var chatRoomDescpription: String?
    var chatRoomAvatarUrl: String?

}
