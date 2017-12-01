//
//  Created by Henry Tran
//  Copyright © 2017 THL. All rights reserved.
//

import UIKit

extension UILabel {

    func bindTo(_ binding: Dynamic<String>?) {
        binding?.onUpdate = { value in
            if value != self.text {
                self.text = value
            }
        }
    }

    func bindTo(_ binding: Dynamic<Int>?) {
        binding?.onUpdate = { value in
            if value?.toString != self.text {
                self.text = value?.toString
            }
        }
    }
}

extension UITextField {

    func bindTo(_ binding: Dynamic<String>?) {
        binding?.onUpdate = { value in
            if value != self.text {
                self.text = value
            }
        }
    }

    func bindTo(_ binding: Dynamic<Int>?) {
        binding?.onUpdate = { value in
            if value?.toString != self.text {
                self.text = value?.toString
            }
        }
    }
}

extension UIButton {

    func bindActionTo(_ binding: Selector?, context: Any?) {
        if let selector = binding {
            self.addTarget(context, action: selector, for: UIControlEvents.touchUpInside)
        }
    }

}
