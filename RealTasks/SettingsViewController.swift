//
//  SettingsViewController.swift
//  RealTasks
//
//  Created by Sean Nam on 8/2/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
   func saveSettings(_ sortIndex: Int!)
}

class SettingsViewController: UIViewController {

    var selectedIndex: Int!
    
    @IBOutlet weak var sortSegmentControl: UISegmentedControl!

    weak var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if selectedIndex == nil {
            selectedIndex = 0
        } else {
            sortSegmentControl.selectedSegmentIndex = selectedIndex!
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onSave(_ sender: Any) {
        delegate?.saveSettings(sortSegmentControl.selectedSegmentIndex)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancel(_ sender: Any) {
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
