//
//  PaperManagedObject+CoreDataProperties.swift
//  ArxivRS
//
//  Created by zhangjun on 15/10/10.
//  Copyright © 2015年 zhangjun. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension PaperManagedObject {

    @NSManaged var document_id: String?
    @NSManaged var title: String?
    @NSManaged var authors: String?
    @NSManaged var update: String?
    @NSManaged var summary: String?

}
