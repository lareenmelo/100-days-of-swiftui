//
//  Die+CoreDataProperties.swift
//  Dados
//
//  Created by Lareen Melo on 8/23/21.
//
//

import Foundation
import CoreData


extension Die {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Die> {
        return NSFetchRequest<Die>(entityName: "Die")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var number: Int16
    @NSManaged public var date: Date?
    
    var intNumber: Int {
        Int(number)
    }
    
    var unwrappedDate: Date {
        return date ?? Date()
    }

}

extension Die : Identifiable {

}
