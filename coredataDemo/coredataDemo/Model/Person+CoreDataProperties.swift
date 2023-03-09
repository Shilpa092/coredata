//
//  Person+CoreDataProperties.swift
//  coredataDemo
//
//  Created by Admin on 14/11/22.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var gender: String?
    @NSManaged public var age: Int64

}

extension Person : Identifiable {

}
