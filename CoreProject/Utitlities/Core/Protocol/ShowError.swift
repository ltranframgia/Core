//
//  Created by Henry Tran
//  Copyright © 2017 THL. All rights reserved.
//

import UIKit
import SnapKit

class ErrorView: UIView {}

protocol ShowError {

    func showError(errorView: ErrorView?, inView: UIView?)

    func hideError()
}

extension ShowError where Self: UIViewController {

    func showError(errorView: ErrorView?, inView: UIView?) {
        self.hideError()
        guard let view = inView else {
            return
        }

        // error container view
        let errorView = errorView ?? ErrorView()
        // added to super view
        self.view.addSubview(errorView)
        self.view.bringSubview(toFront: errorView)

        // constraint
        errorView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
    }

    func hideError() {
        if let errorView = self.view.subviews.reversed().first(where: {$0 is ErrorView }) as? ErrorView {
            errorView.removeFromSuperview()
        }
    }
}
