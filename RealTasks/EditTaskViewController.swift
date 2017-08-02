//
//  EditTaskViewController.swift
//  RealTasks
//
//  Created by Sean Nam on 8/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit
import RealmSwift

protocol EditTaskViewControllerDelegate: class {
    func editTask(_ taskId: String!)
}

class EditTaskViewController: UIViewController {

    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var prioritySegementedControl: UISegmentedControl!
    @IBOutlet weak var dueDateTextField: UITextField!
    
    weak var delegate: EditTaskViewControllerDelegate?
    
    var taskName: String?
    var priorityLevel: Int?
    var dueDate: Date?
    var dueDateString: String?
    //var index: Int!
    var taskId: String?
    
    var realm = try! Realm()
    var taskList: Results<Todo> {
        get {
            return realm.objects(Todo.self)
        }
    }
    var tasks = List<Todo>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
        
        for Todo in taskList {
            tasks.append(Todo)
        }
        
        if taskName != nil {
            taskNameTextField.text = taskName
        }
        
        if dueDateString != nil {
            dueDateTextField.text = dueDateString
        }
        
        if priorityLevel != nil {
            prioritySegementedControl.selectedSegmentIndex = priorityLevel!
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDone(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dueDate = dateFormatter.date(from: dueDateTextField.text!)
        
        taskName = taskNameTextField.text
        priorityLevel = prioritySegementedControl.selectedSegmentIndex
        
        let updateTask = Todo()
        updateTask.taskName = taskName!
        updateTask.dueDate = dueDate! as NSDate
        updateTask.priorityLevel = priorityLevel!
        updateTask.done = false
        updateTask.taskId = self.taskId!
        
        try! realm.write {
            delegate?.editTask(taskId)
            print("Updating existing task to Realm DB")
            realm.add(updateTask, update: true)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPickDate(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.minimumDate = Date()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
    }
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dueDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
