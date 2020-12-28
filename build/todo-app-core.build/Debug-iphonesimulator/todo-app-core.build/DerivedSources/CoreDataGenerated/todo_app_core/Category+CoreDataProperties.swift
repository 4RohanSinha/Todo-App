//
//  Category+CoreDataProperties.swift
//  
//
//  Created by Rohan Sinha on 12/27/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var entities: NSSet?

}

// MARK: Generated accessors for entities
extension Category {

    @objc(addEntitiesObject:)
    @NSManaged public func addToEntities(_ value: Todo)

    @objc(removeEntitiesObject:)
    @NSManaged public func removeFromEntities(_ value: Todo)

    @objc(addEntities:)
    @NSManaged public func addToEntities(_ values: NSSet)

    @objc(removeEntities:)
    @NSManaged public func removeFromEntities(_ values: NSSet)

}

extension Category : Identifiable {

}
