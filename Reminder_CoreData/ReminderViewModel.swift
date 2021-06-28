//
//  ReminderViewModel.swift
//  Reminder_CoreData
//
//  Created by Ramesh on 28/06/21.
//

import Foundation
import UserNotifications

class ReminderViewModel {
    var reminderModelObj = ReminderModel()
    
    // MARK: - FETCH DATA
    func fetchData(){
        reminderModelObj.reminderTitle = []
        reminderModelObj.reminderID = []
        reminderModelObj.reminderDateTime = []
        
        do {
            guard let fetch = try PersistanceStorage.sharedInstance.context.fetch(ReminderList.fetchRequest()) as? [ReminderList]else  {return}
            
            for emp in fetch {
                reminderModelObj.reminderTitle?.append(emp.title ?? "no title")
                reminderModelObj.reminderDateTime?.append(emp.dateTime ?? "no date")
                reminderModelObj.reminderID?.append(emp.id ?? UUID())
            }
        } catch let error {
            print(error)
        }
        
    }
    
    // MARK: - UPDATE NOTIFICATION
    func updateNotification(id: UUID ,title: String, date: Date){
        
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.sound = .default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],from: date),repeats: false)
        
        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print("something went wrong")
            }
        })
    }
    
}


