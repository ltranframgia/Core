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
        guard let _view = inView else {
            return
        }

        // error container view
        let _errorView = errorView ?? ErrorView()
        // added to super view
        self.view.addSubview(_errorView)
        self.view.bringSubview(toFront: _errorView)

        // constraint
        _errorView.snp.makeConstraints { (make) in
            make.top.equalTo(_view.snp.top)
            make.bottom.equalTo(_view.snp.bottom)
            make.left.equalTo(_view.snp.left)
            make.right.equalTo(_view.snp.right)
        }
    }

    func hideError() {
        if let errorView = self.view.subviews.reversed().first(where: {$0 is ErrorView }) as? ErrorView {
            errorView.removeFromSuperview()
        }
    }
}
