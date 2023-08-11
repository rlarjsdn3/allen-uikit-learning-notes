//
//  Entity+CoreDataProperties.swift
//  ToDoApp
//
//  Created by 김건우 on 2023/08/11.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var memoText: String?
    @NSManaged public var date: Date?
    @NSManaged public var color: Int64

}

extension Entity : Identifiable {

}
