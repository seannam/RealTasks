//
//  AddTaskViewController.swift
//  RealTasks
//
//  Created by Sean Nam on 8/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit

protocol AddTaskDelegate: class {
    func passTask(_ name: String!, _ priority: Int, _ dueDate: String!)
}

class AddTaskViewController: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var prioritySegementedControl: UISegmentedControl!
    @IBOutlet weak var dueDateTextField: UITextField!
    
    weak var delegate: AddTaskDelegate?

    
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
        let dueDate = dueDateTextField.text!
        
        delegate?.passTask(taskName, priorityLevel, dueDate)
        
        self.dismiss(animated: true, completion: nil)
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
