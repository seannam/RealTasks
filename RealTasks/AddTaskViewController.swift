//
//  AddTaskViewController.swift
//  RealTasks
//
//  Created by Sean Nam on 8/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit
import RealmSwift

protocol AddTaskDelegate: class {
    func addTask(_ name: String!, _ priority: Int, _ dueDate: NSDate!)
    //func saveTask(_ task: Task)
}

class AddTaskViewController: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var prioritySegementedControl: UISegmentedControl!
    @IBOutlet weak var dueDateTextField: UITextField!
    
    weak var delegate: AddTaskDelegate?
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        let taskName = taskTextField.text!
        let priorityLevel = prioritySegementedControl.selectedSegmentIndex
        let dueDateString = dueDateTextField.text!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dueDate = dateFormatter.date(from: dueDateString)
        
        let task = Task(taskName: taskName, priorityLevel: priorityLevel, dueDate: dueDate! as NSDate)
        task.saveTask()
        
        //delegate?.saveTask(task)
        
        
        let newTask = Todo()
        newTask.taskName = taskName
        newTask.dueDate = dueDate! as NSDate
        newTask.priorityLevel = String(priorityLevel)
        newTask.done = false
        
        try! self.realm.write({
            self.realm.add(newTask)
            print("Adding task to Realm DB")
            delegate?.addTask(taskName, priorityLevel, dueDate! as NSDate)
        })
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
        dateFormatter.dateStyle = DateFormatter.Style.full
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
