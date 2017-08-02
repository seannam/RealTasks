//
//  Todo.swift
//  RealTasks
//
//  Created by Sean Nam on 8/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit
import RealmSwift

class Todo: Object {
    dynamic var taskName = ""
    dynamic var priorityLevel = ""
    dynamic var dueDate = NSDate()
    dynamic var done = false

    dynamic var taskId = ""
    
    override static func primaryKey() -> String? {
        return "taskId"
    }
    
}

//class TaskList: Object {
//    dynamic var name = ""
//    let tasks = List<Todo>()
//}
