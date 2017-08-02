//
//  ViewController.swift
//  RealTasks
//
//  Created by Sean Nam on 8/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var taskTableView: UITableView!

//    var data = [""]
//    var priorityList = [""]
//    var dueDateList = [""]
    
    var realm: Realm!
    
    var taskList: Results<Todo> {
        get {
            return realm.objects(Todo.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false

        // Do any additional setup after loading the view, typically from a nib.
        taskTableView.dataSource = self

        realm = try! Realm()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

//        if segue.identifier == "AddTaskSegue" || segue.identifier == "EditTaskSegue" || segue.identifier == "TaskDetailSegue" {
//            let navController = segue.destination as? UINavigationController
//            let addTaskVC = navController?.topViewController as? AddTaskViewController
//
//            if let viewController = addTaskVC {
//                viewController.delegate = self
//            }
//        }
        
        if segue.identifier == "TaskDetailSegue" {
            let cell = sender as! TaskCell
            let indexPath = taskTableView.indexPath(for: cell)
            let task = taskList[(indexPath?.row)!]
            
            let editTaskVC = segue.destination as! EditTaskViewController
            
            editTaskVC.taskName = task.taskName
            editTaskVC.dueDate = task.dueDate
            editTaskVC.priorityLevel = Int(task.priorityLevel)
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = taskTableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        
        let task = taskList[indexPath.row]
        
        cell.nameLabel!.text = task.taskName
        cell.dueDateLabel.text = task.dueDate
        cell.priorityLevelLabel.text = task.priorityLevel
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return data.count
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        taskTableView.deselectRow(at: indexPath, animated: true)
        taskTableView.reloadRows(at: [indexPath], with: .automatic)
        
        let task = taskList[indexPath.row]
        try! self.realm.write({
            task.done = !task.done
        })
        
        taskTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            let task = taskList[indexPath.row]
            try! self.realm.write({
                self.realm.delete(task)
            })
            
            taskTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
//    func passTask(_ name: String!, _ priority: Int, _ dueDate: String!) {
//        data.append(name)
//        priorityList.append(String(priority))
//        dueDateList.append(dueDate)
//        taskTableView.reloadData()
//    }

}

