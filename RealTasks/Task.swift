//
//  Task.swift
//  RealTasks
//
//  Created by Sean Nam on 8/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit

class Task: NSObject {
    
    var taskName: String?
    var priorityLevel: Int?
    var dueDate: String?
//    var createdDate: Date?
    
    init(taskName: String, priorityLevel: Int, dueDate: String) {
        self.taskName = taskName
        self.priorityLevel = priorityLevel
        self.dueDate = dueDate
    }

    
    func saveTask() {
        
    }
}
