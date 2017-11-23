//
//  Created by Henry Tran
//  Copyright © 2017 THL. All rights reserved.
//

public struct GroupItem<Group, Item> {
    public var group: Group
    public var items: [Item]

    public init(group: Group, items: [Item]) {
        self.group = group
        self.items = items
    }
}

struct MimeType {
    static let imageAll             = "image/*"
    static let imageJpeg            = "image/jpeg"
    static let imagePng             = "image/png"
}
