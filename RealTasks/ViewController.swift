//
//  ViewController.swift
//  RealTasks
//
//  Created by Sean Nam on 8/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, AddTaskViewControllerDelegate, EditTaskViewControllerDelegate {

    @IBOutlet weak var taskTableView: UITableView!

    var realm: Realm!
    
    var taskList: Results<Todo> {
        get {
            return realm.objects(Todo.self)
        }
    }
    var tasks = List<Todo>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false

        // Do any additional setup after loading the view, typically from a nib.
        taskTableView.dataSource = self

        realm = try! Realm()
        
        for Todo in taskList {
            tasks.append(Todo)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.taskTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddTaskSegue" || segue.identifier == "EditTaskSegue" || segue.identifier == "TaskDetailSegue" {
            let navController = segue.destination as? UINavigationController
            let addTaskVC = navController?.topViewController as? AddTaskViewController

            if let viewController = addTaskVC {
                viewController.delegate = self
            }
        }
        
        if segue.identifier == "TaskDetailSegue" {
            let cell = sender as! TaskCell
            let indexPath = taskTableView.indexPath(for: cell)
            let task = taskList[(indexPath?.row)!]
            
            let editTaskVC = segue.destination as! EditTaskViewController
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let dueDateString = dateFormatter.string(from: task.dueDate as Date)
            
            editTaskVC.dueDate = task.dueDate as Date
            editTaskVC.dueDateString = dueDateString
            editTaskVC.taskName = task.taskName
            editTaskVC.priorityLevel = Int(task.priorityLevel)
            editTaskVC.index = indexPath?.row
            editTaskVC.taskId = task.taskId
            
            print("priorityLevel value in ViewController = \(task.priorityLevel)")
            print("index value in ViewController = \(String((indexPath?.row)!))")
        }

    }
    @IBAction func editTasks(_ sender: Any) {
        self.taskTableView.setEditing(!taskTableView.isEditing, animated: true)
        
        if taskTableView.isEditing == true {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTasks(_:)))
        }
        if taskTableView.isEditing == false {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTasks(_:)))
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = taskTableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        let task = taskList[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dueDateString = dateFormatter.string(from: task.dueDate as Date)
        
        cell.nameLabel!.text = task.taskName
        cell.dueDateLabel.text = dueDateString
        cell.priorityLevelLabel.text = task.priorityLevel
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let task = taskList[indexPath.row]
        try! self.realm.write({
            task.done = !task.done
        })
        
        taskTableView.deselectRow(at: indexPath, animated: true)
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
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

//        try! self.realm?.write {
//            tasks.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
//            print("rearranging")
//        }
    }
    
    func addTask() {
        self.taskTableView.insertRows(at: [IndexPath.init(row:self.taskList.count-1, section: 0)], with: .automatic)
    }
    
    func editTask(_ rowIndex: Int!) {
        self.taskTableView.reloadData()
        print("rowIndex in VC = \(rowIndex!)")
        self.taskTableView.reloadRows(at: [IndexPath.init(row:rowIndex, section: 0)], with: .automatic)
    }
    
}

