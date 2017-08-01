//
//  AddTaskViewController.swift
//  RealTasks
//
//  Created by Sean Nam on 8/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit

protocol AddTaskDelegate: class {
    func passTaskName(_ name: String!)
}

class AddTaskViewController: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    
    //let alertController = UIAlertController(title: "Error", message: "Task is blank", preferredStyle: .alert)
    weak var delegate: AddTaskDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        print("Cancel button pressed")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        let task = taskTextField.text!
        delegate?.passTaskName(task)
        
        print("Save button pressed")
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
