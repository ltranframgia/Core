//
//  Created by Henry Tran
//  Copyright © 2017 THL. All rights reserved.
//

import UIKit
import Foundation

public protocol ViewModelComfortable {}
public typealias CellModelInfo = (viewModel: ViewModelComfortable?, size: CGSize)

class Dynamic<T> {

    typealias Listener = (T?) -> Void
    private var listenerQueue: [Listener?] = []

    // listener
    var onUpdate: Listener? {
        didSet {
            listenerQueue.append(onUpdate)
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

public struct ResponseDynamic {
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

protocol LoadingBindable {
    var loading: Dynamic<Loading> { get }
}

protocol DataRequestable {
    var isRequesting: Bool? { get }
    func doGetData(_ loadingType: LoadingType?)
}

protocol TableViewModelBindable: DataRequestable, LoadingBindable {
    var tableView: TableViewDynamic { get }
    var listCells: [CellModelInfo] { get set }

    func numberOfRows(in section: Int) -> Int
    func heightCell(at indexPath: IndexPath) -> CGFloat
    func cellViewModel(at indexPath: IndexPath ) -> ViewModelComfortable?
}

extension TableViewModelBindable {

    func numberOfRows(in section: Int) -> Int {
        return listCells.count
    }

    func heightCell(at indexPath: IndexPath) -> CGFloat {
        return listCells[indexPath.row].size.height
    }

    func cellViewModel(at indexPath: IndexPath ) -> ViewModelComfortable? {
        return listCells[indexPath.row].viewModel
    }
}
