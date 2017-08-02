//
//  ViewController.swift
//  RealTasks
//
//  Created by Sean Nam on 8/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, AddTaskViewControllerDelegate, EditTaskViewControllerDelegate, SettingsViewControllerDelegate, UISearchResultsUpdating {

    @IBOutlet weak var taskTableView: UITableView!

    var searchController: UISearchController!
    var settingsDidChange = false
    var sortIndex: Int!
    var realm: Realm!
    var taskList: Results<Todo> {
        get {
            return realm.objects(Todo.self)
        }
    }
    var todoList = List<Todo>()
   
    var searchResults = try! Realm().objects(Todo.self)
    var sortedList = try! Realm().objects(Todo.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.taskTableView.dataSource = self

        realm = try! Realm()

        definesPresentationContext = true
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        taskTableView.tableHeaderView = searchController.searchBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.taskTableView.reloadData()
        
        for todo in taskList {
            todoList.append(todo)
        }
        
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

        if segue.identifier == "SettingsSegue" {
            let navController = segue.destination as? UINavigationController
            let settingsVC = navController?.topViewController as? SettingsViewController
            
            if let viewController = settingsVC {
                viewController.delegate = self
            }
            settingsVC?.selectedIndex = self.sortIndex
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
            editTaskVC.taskId = task.taskId
            
        }

    }
    @IBAction func editTasks(_ sender: Any) {
        self.taskTableView.setEditing(!taskTableView.isEditing, animated: true)
        
        if taskTableView.isEditing == true {
            navigationItem.rightBarButtonItems?[0] = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTasks(_:)))
//            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTasks(_:)))
        }
        if taskTableView.isEditing == false {
            navigationItem.rightBarButtonItems?[0] = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTasks(_:)))
            //navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTasks(_:)))
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = taskTableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        var task = taskList[indexPath.row]
        
        if settingsDidChange {
            task = sortedList[indexPath.row]
        }
        
        if searchController.isActive {
            if indexPath.row < searchResults.count {
                task = searchResults[indexPath.row]
            } else {
                // Handle non-existing object here
                print("realm error")
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dueDateString = dateFormatter.string(from: task.dueDate as Date)
        
        cell.nameLabel!.text = task.taskName
        cell.dueDateLabel.text = dueDateString
        cell.priorityLevelLabel.text = String(task.priorityLevel)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? searchResults.count : taskList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let task = taskList[indexPath.row]
        try! self.realm.write({
            task.done = !task.done
        })
        
        //taskTableView.deselectRow(at: indexPath, animated: true)
        //taskTableView.reloadRows(at: [indexPath], with: .automatic)
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

        try! todoList.realm?.write {
            todoList.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
            print("rearranging")
            //print(todoList)
            print(sourceIndexPath.row)
            print(destinationIndexPath.row)
        }
    }
    
    func addTask() {
        self.taskTableView.insertRows(at: [IndexPath.init(row:self.taskList.count-1, section: 0)], with: .automatic)
    }
    
    func editTask(_ taskId: String!) {
        self.taskTableView.reloadData()
        //self.taskTableView.reloadRows(at: [IndexPath.init(row:rowIndex, section: 0)], with: .automatic)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            searchResults = realm.objects(Todo.self).filter("taskName CONTAINS[c] %@", searchText)
            
            print("searchText=\(searchText)")
            print(searchResults.endIndex)
            print(searchResults)
            
            taskTableView.reloadData()
        }
    }
    
    func saveSettings(_ sortIndex: Int!) {
        self.settingsDidChange = true
        self.sortIndex = sortIndex
        
        switch sortIndex {
        case 0:
            // priorities - high to low
            sortedList = realm.objects(Todo.self).sorted(byKeyPath: "priorityLevel", ascending: false)
            break
        case 1:
            // priorities - low to high
            sortedList = realm.objects(Todo.self).sorted(byKeyPath: "priorityLevel", ascending: true)
            break
        case 2:
            // due date - earliest to latest
            sortedList = realm.objects(Todo.self).sorted(byKeyPath: "dueDate", ascending: true)
            break
        case 3:
            // due date - latest to earliest
            sortedList = realm.objects(Todo.self).sorted(byKeyPath: "dueDate", ascending: false)
            break
        default:
            break
        }
    }
    
}

