//
//  Category.swift
//  Todoey
//
//  Created by Jeremy Adam on 09/05/19.
//  Copyright © 2019 Underway. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name:String = ""
    let items = List<Item>()
}
