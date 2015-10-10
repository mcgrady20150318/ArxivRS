//
//  Tag+CoreDataProperties.swift
//  
//
//  Created by zhangjun on 15/10/9.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Tag {

    @NSManaged var id: NSNumber?
    @NSManaged var name: String?

}
