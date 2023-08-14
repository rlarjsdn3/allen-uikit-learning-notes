//
//  Entity+CoreDataProperties.swift
//  ToDoApp
//
//  Created by 김건우 on 2023/08/11.
//
//

import Foundation
import CoreData


extension ToDoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoData> {
        return NSFetchRequest<ToDoData>(entityName: "ToDoData")
    }

    @NSManaged public var memoText: String?
    @NSManaged public var date: Date?
    @NSManaged public var color: Int64
    
    var dateString: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = self.date else { return "" }
        let savedDateString = formatter.string(from: date)
        return savedDateString
    }
}

extension ToDoData : Identifiable {

}
