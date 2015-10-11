//: Playground - noun: a place where people can play

import UIKit
import CoreData
import Foundation


let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

let f = NSFetchRequest(entityName: "Tag")

do{
    
    let data = try context.executeFetchRequest(f)
    
    print(data.count)
    
    return data
    
    
}catch{}















