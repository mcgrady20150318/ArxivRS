//
//  PaperManagedObject+CoreDataProperties.swift
//  
//
//  Created by zhangjun on 15/10/10.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension PaperManagedObject {

    @NSManaged var authors: String?
    @NSManaged var document_id: String?
    @NSManaged var summary: String?
    @NSManaged var title: String?
    @NSManaged var update: String?
    @NSManaged var isLike: NSNumber?
    @NSManaged var isBookmark: NSNumber?

}
