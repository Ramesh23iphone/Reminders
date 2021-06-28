//
//  ReminderList+CoreDataProperties.swift
//  Reminder_CoreData
//
//  Created by Ramesh on 26/06/21.
//
//

import Foundation
import CoreData


extension ReminderList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReminderList> {
        return NSFetchRequest<ReminderList>(entityName: "ReminderList")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var dateTime: String?

}

extension ReminderList : Identifiable {

}
