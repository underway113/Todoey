//
//  ToDoModel.swift
//  Todoey
//
//  Created by Jeremy Adam on 07/05/19.
//  Copyright © 2019 Underway. All rights reserved.
//

import Foundation

class  ToDoModel {
    var title:String = ""
    var status:Bool = false
    
    init(_ titleSet:String, _ statusSet:Bool) {
        title = titleSet
        status = statusSet
    }
}
