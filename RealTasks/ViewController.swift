//
//  ViewController.swift
//  RealTasks
//
//  Created by Sean Nam on 8/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, AddTaskDelegate {

    @IBOutlet weak var taskTableView: UITableView!
    
//    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
//                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
//                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN"]

    var data = [""]
    var priorityList = [""]
    var dueDateList = [""]
    
    @IBOutlet weak var cellTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false

        // Do any additional setup after loading the view, typically from a nib.
        taskTableView.dataSource = self
        
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
            let task = data[(indexPath?.row)!]
            let priority = priorityList[(indexPath?.row)!]
            let dueDate = dueDateList[(indexPath?.row)!]
            
            let editTaskVC = segue.destination as! EditTaskViewController
            
            editTaskVC.taskName = task
            editTaskVC.dueDate = dueDate
            editTaskVC.priorityLevel = Int(priority)!
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        cell.textLabel?.text = data[indexPath.row]
        
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        cell.nameLabel.text = data[indexPath.row]
        cell.dueDateLabel.text = dueDateList[indexPath.row]
        cell.priorityLevelLabel.text = priorityList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
    func passTask(_ name: String!, _ priority: Int, _ dueDate: String!) {
        data.append(name)
        priorityList.append(String(priority))
        dueDateList.append(dueDate)
        taskTableView.reloadData()
    }

}

