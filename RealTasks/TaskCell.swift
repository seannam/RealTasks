//
//  TaskCell.swift
//  RealTasks
//
//  Created by Sean Nam on 8/1/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit
import RealmSwift

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var priorityLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
//        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
//    }
//    
//    required init(coder: NSCoder) {
//        fatalError("NSCoding not supported")
//    }
}
