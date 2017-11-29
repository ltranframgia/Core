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

extension UITableView {

    func showLoadMoreFooterView(_ completionHandler: @escaping () -> Void) {

        // create indicatorview
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.activityIndicatorViewStyle = .gray

        // footerView
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 50))
        footerView.addSubview(activityIndicatorView)
        activityIndicatorView.center = footerView.center
        footerView.backgroundColor = UIColor.clear

        // set to footerView
        self.tableFooterView = footerView

        // animating
        activityIndicatorView.startAnimating()

        // call back
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            completionHandler()
        }
    }

    func hideLoadMoreFooterView() {
        UIView.animate(withDuration: 0.3) {
            self.tableFooterView = nil
        }
    }
}
