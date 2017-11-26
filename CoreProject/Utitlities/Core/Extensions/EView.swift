//
//  Created by Henry Tran
//  Copyright © 2017 THL. All rights reserved.
//

import UIKit

// MARK: TableViewCell
extension UITableViewCell {

    static func registerNibIn(_ tableView: UITableView) {
        let identifier = String(describing: self)
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }

    static func dequeueReusableCellFrom<T: UITableViewCell>(_ tableView: UITableView, indexPath: IndexPath) -> T {
        let identifier = String(describing: self)
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T {
            return cell
        }
        return T()
    }

}
