//
//  ReminderCellTableViewCell.swift
//  Reminder_CoreData
//
//  Created by Ramesh on 26/06/21.
//

import UIKit

class ReminderCellTableViewCell: UITableViewCell {

    @IBOutlet weak var reminderTitile: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var checkBtnObj: UIButton!
    var selectedItem = false
    let checkedImage = UIImage(named: "Check")! as UIImage
    let uncheckedImage = UIImage(named: "Uncheck")! as UIImage
    @IBAction func checkBtn(_ sender: Any) {
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
             
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        }

}
