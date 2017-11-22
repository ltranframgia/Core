//
//  TraineeTableViewCell.swift
//  ToeicCoach
//
//  Created by Henry Tran on 10/16/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol TableViewCellTraineeDelegate: class {

    func tableViewCell(tableViewCell: UITableViewCell, touchChatButtonAtIndexPath: IndexPath?)

}

class TraineeTableViewCell: UITableViewCell {

    static let height: CGFloat = 120
    weak var delegate: TableViewCellTraineeDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func touchChatButtonAction(_ sender: UIButton) {
        self.delegate?.tableViewCell(tableViewCell: self, touchChatButtonAtIndexPath: nil)
    }
}
