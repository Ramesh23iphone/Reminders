//
//  CreateReminderViewModel.swift
//  Reminder_CoreData
//
//  Created by Ramesh on 28/06/21.
//

import Foundation

class createReminderViewModel {
    
    
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
}
