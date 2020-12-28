//
//  Todo+CoreDataProperties.swift
//  
//
//  Created by Rohan Sinha on 12/27/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var due_date: Date?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var priority: String?
    @NSManaged public var task: String?

}

extension Todo : Identifiable {

}
