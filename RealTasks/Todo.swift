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
    dynamic var priorityLevel = 0
    dynamic var dueDate = NSDate()
    dynamic var done = false

    dynamic var taskId = ""
    
    override static func primaryKey() -> String? {
        return "taskId"
    }
    //let todoList = List<Todo>()
    let items = List<Todo>()
    
}

//class TaskList: Object {
//    dynamic var name = ""
//    let tasks = List<Todo>()
//}
