//
//  AddTaskViewController.swift
//  RealTasks
//
//  Created by Sean Nam on 8/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit
import RealmSwift

protocol AddTaskViewControllerDelegate: class {
    func addTask()
}

class AddTaskViewController: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var prioritySegementedControl: UISegmentedControl!
    @IBOutlet weak var dueDateTextField: UITextField!
    
    weak var delegate: AddTaskViewControllerDelegate?
    
    let realm = try! Realm()
    var tasks = List<Todo>()
    
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

        let newTask = Todo()
        
        if !taskName.isEmpty {
            newTask.taskName = taskName
        } else {
            newTask.taskName = "Untitled"
        }
        
        if !dueDateString.isEmpty {
            newTask.dueDate = dueDate! as NSDate
        }
        
        newTask.priorityLevel = priorityLevel
        newTask.done = false
        newTask.taskId = String(NSUUID().uuidString)
        
        try! self.realm.write({
            self.realm.add(newTask)
            print("Adding task to Realm DB")
            delegate?.addTask()
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
