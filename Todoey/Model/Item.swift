//
//  Item.swift
//  Todoey
//
//  Created by Jeremy Adam on 09/05/19.
//  Copyright © 2019 Underway. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title:String = ""
    @objc dynamic var status:Bool = false
    @objc dynamic var dateCreated:Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
