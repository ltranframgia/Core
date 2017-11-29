//
//  Created by Henry Tran
//  Copyright © 2017 THL. All rights reserved.
//

import UIKit
import Foundation

public protocol ViewModelComfortable {}
public typealias CellModelInfo = (viewModel: ViewModelComfortable?, height: CGFloat)

class Dynamic<T> {

    typealias Listener = (T?) -> Void
    private var listenerQueue: [Listener?] = []

    // listener
    var listener: Listener? {
        didSet {
            listenerQueue.append(listener)
        }
    }

    // value
    var value: T? {
        didSet {
            listenerQueue.forEach {
                $0?(value)
            }
        }
    }

    // init
    init(_ value: T? = nil) {
        self.value = value
    }

    func clear() {
        listenerQueue.removeAll()
    }
}

public struct RequestDynamic {
    var success: Dynamic<Bool> = Dynamic()
    var error: Dynamic<ResponseObject> = Dynamic()
    var cancel: Dynamic<Bool> = Dynamic()
}

public struct TableViewDynamic {
    var reloadData: Dynamic<Bool> = Dynamic()
    var insertRows: Dynamic<(Bool, [IndexPath]?)> = Dynamic()
    var deleteRows: Dynamic<(Bool, [IndexPath]?)> = Dynamic()
    var reloadRows: Dynamic<(Bool, [IndexPath]?)> = Dynamic()
}
