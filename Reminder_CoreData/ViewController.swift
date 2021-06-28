//
//  ViewController.swift
//  Reminder_CoreData
//
//  Created by Ramesh on 26/06/21.
//

import UIKit
import CoreData
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    var reminderViewModel = ReminderViewModel()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        tableView.register(ReminderCellTableViewCell.self, forCellReuseIdentifier: "ReminderCellTableViewCell")
        self.navigationItem.title = "Reminder"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reminderViewModel.fetchData()
        tableView.reloadData()
        if reminderViewModel.reminderModelObj.reminderID == []{
            tableView.isHidden = true
        }else{
            tableView.isHidden = false
        }
    }
    
    // MARK: - ADD REMINEDER
    @IBAction func addReminder(_ sender: Any) {
        //  let vc = CreateReminderController()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateReminderController") as! CreateReminderController
        vc.navigationItem.leftBarButtonItem?.title = ""
        vc.navigationController?.navigationBar.backItem?.title = " "

        vc.completion = { id, title, date in
            DispatchQueue.main.async {
                
                self.reminderViewModel.updateNotification(id: id, title: title, date: date)
                
                
            }
        }
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    
    
    
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminderViewModel.reminderModelObj.reminderTitle?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReminderCellTableViewCell
        
        cell.reminderTitile.text = reminderViewModel.reminderModelObj.reminderTitle?[indexPath.row]
        cell.time.text = reminderViewModel.reminderModelObj.reminderDateTime?[indexPath.row]
        let id = reminderViewModel.reminderModelObj.reminderID?[indexPath.row]
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
            for notificationRequest:UNNotificationRequest in notificationRequests {
                print(notificationRequest.identifier)
                DispatchQueue.main.async {
                    
                    if id?.uuidString == notificationRequest.identifier{
                        cell.checkBtnObj.setImage(cell.checkedImage, for: .normal)
                    }
                }
            }
            
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            do {
                guard let fetch = try PersistanceStorage.sharedInstance.context.fetch(ReminderList.fetchRequest()) as? [ReminderList]else  {return}
                var delArray = [UUID().uuidString]
                for i in fetch{
                    delArray.append(i.id!.uuidString)
                }
                let deleteID = delArray[indexPath.row + 1]
                
                UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
                    for notificationRequest:UNNotificationRequest in notificationRequests {
                        print(notificationRequest.identifier)
                        if deleteID == notificationRequest.identifier{
                            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [(notificationRequest.identifier)])
                        }
                    }
                    
                }
                
                
                
                PersistanceStorage.sharedInstance.context.delete(fetch[indexPath.row])
                
                
                PersistanceStorage.sharedInstance.saveContext()
                reminderViewModel.fetchData()
                
                
                
                self.tableView.reloadData()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
}

