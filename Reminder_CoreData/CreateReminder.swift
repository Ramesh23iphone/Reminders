//
//  CreateReminder.swift
//  Reminder_CoreData
//
//  Created by Ramesh on 26/06/21.
//

import Foundation
import UIKit
import CoreData

class CreateReminderController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var reminderTitle: UITextView!
    @IBOutlet weak var dateBtnObj: UIButton!
        
    var toolBar : UIToolbar!
    public var completion: ((UUID, String, Date) -> Void)?

    var dateTime = ""
    var saveAsDate :NSDate?
    
    @IBAction func dateBtnClicked(_ sender: Any) {
        
        UIView.animate(withDuration: 0.8, animations: {
            self.datePicker.isHidden = !self.datePicker.isHidden
        })
        
            
        
    }
    
    func showAlert(message: String)  {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

    @IBAction func createReminderClicked(_ sender: Any) {
        
        if  reminderTitle.text == "" || reminderTitle.text == "Remind me about"{
            showAlert(message: "Enter reminder details")
        }else if saveAsDate == nil{
            showAlert(message: "Select date and time")
        }else{
       
        
        let persistence = ReminderList(context: PersistanceStorage.sharedInstance.context)
        persistence.title = reminderTitle.text
      
        persistence.id = UUID()
        persistence.dateTime = dateTime
        PersistanceStorage.sharedInstance.saveContext()
        

        
        completion?(persistence.id!, reminderTitle.text,saveAsDate! as Date)
        self.navigationController?.popViewController(animated: false)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.isHidden = true
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        datePicker.minimumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
        self.navigationItem.title = "Add Reminder"
        reminderTitle.text = "Remind me about"
        reminderTitle.textColor = UIColor.lightGray
        reminderTitle.delegate = self
        dateBtnObj.layer.borderWidth = 1
        dateBtnObj.layer.cornerRadius = 5
        dateBtnObj.layer.borderColor = CGColor(red: 0 , green: 0, blue: 0, alpha: 1)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)

    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

          if text == "\n" {
              textView.resignFirstResponder()
              return false
          }
          return true
      }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
        self.datePicker.isHidden = true
    }
    
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: sender.date)
        saveAsDate = sender.date as NSDate


        
        if let day = components.day, let month = components.month, let year = components.year, let hour = components.hour, let min = components.minute {
            
            let monthFor = monthFormat(month: month)
            
            dateBtnObj.setTitle("\(day) \(monthFor) \(year) \(hour) \(min)", for: .normal)
            dateTime = "\(day) \(monthFor) \(year) \(hour) \(min)"
        }
    }
    
    

    
    func monthFormat(month: Int)->String{
        switch month {
        case 1:
            return "Jan"
        case 2:
            return "Feb"
        case 3:
            return "Mar"
        case 4:
            return "Apr"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "Aug"
        case 9:
            return "Sept"
        case 10:
            return "Oct"
        case 11:
            return "Nov"
        case 12:
            return "Dec"
        default:
            break
        }
        return ""
    }
    
     func textViewDidBeginEditing(_ textView: UITextView) {
        reminderTitle.becomeFirstResponder()
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
   
    
 
}


