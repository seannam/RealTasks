//
//  AddTaskViewController.swift
//  RealTasks
//
//  Created by Sean Nam on 8/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:320, height:44))
//        self.view.addSubview(navBar)
//        
//        let navItem = UINavigationItem(title: "Add Task")
//        
//        let cancelItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: nil, action: #selector(onCancelButton(_:)))
//        let saveItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: nil, action: #selector(onSaveButton(_:)))
//        
//        navItem.leftBarButtonItem = cancelItem
//        navItem.rightBarButtonItem = saveItem
//        navBar.setItems([navItem], animated: false)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        print("Cancel button pressed")
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        print("Save button pressed")
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
