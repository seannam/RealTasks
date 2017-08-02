//
//  EditTaskViewController.swift
//  RealTasks
//
//  Created by Sean Nam on 8/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit

class EditTaskViewController: UIViewController {

    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var prioritySegementedControl: UISegmentedControl!
    @IBOutlet weak var dueDateTextField: UITextField!
    
    var taskName: String?
    var priorityLevel: Int?
    var dueDate: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if taskName != nil {
            taskNameTextField.text = taskName
        }
        
        if dueDate != nil {
            dueDateTextField.text = dueDate
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
//    @IBAction func onCancel(_ sender: Any) {
//        print("cancel")
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    @IBAction func onSave(_ sender: Any) {
//        print("saving")
//        dismiss(animated: true, completion: nil)
//        //self.dismiss(animated: true, completion: nil)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
