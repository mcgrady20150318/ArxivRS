//
//  DataExtension.swift
//  ArxivRS
//
//  Created by zhangjun on 15/10/10.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import Foundation
import CoreData

extension TagViewController{
    
    
    func insertData(t:TagModel){
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let tag = NSEntityDescription.insertNewObjectForEntityForName("Tag", inManagedObjectContext: context) as! TagManagedObject
        
        tag.setValue(t.name, forKey: "name")
        
        do{try context.save()}
            
        catch{}
        
        
    }
    
    
    func findAllData() -> [TagModel]{
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let f = NSFetchRequest(entityName: "Tag")
        
        var tag:[TagModel]? = []
        
        do{
            
            let data = try context.executeFetchRequest(f) as NSArray
            
            for(var i=0;i<data.count;i++){
                
                let item = data[i] as! TagManagedObject
                
                tag?.append(TagModel(name:(item.valueForKey("name") as? String)!))

            
            }
            
            return tag!
            
            
            
        }catch{}
        
        return []
        
    }
    
    
    func deleteOneRowByIndex(index:Int){
        
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let f = NSFetchRequest(entityName: "Tag")
        
        var data:[AnyObject]
        
        do{
            
            data = try context.executeFetchRequest(f)
            
            context.deleteObject(data[index] as! NSManagedObject )
            
            do{try context.save()}
                
            catch{}
            
            
        }catch{}
        
        
    }


}

extension PaperViewController{
    
    func findIsTrue(title:String,content:String) -> Bool{
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let f = NSFetchRequest(entityName: "Paper")
        
        f.predicate = NSPredicate(format: "title = %@ and \(content) = true", title)
        
        var data:[AnyObject]?
        
        do{
            
            data = try context.executeFetchRequest(f)
            
            print(data?.count)
            
            if data!.count > 0{
                
                return true
                
            }else{
                
                return false
            }

            
        }catch{}
        
        
        
        return false
        
        
    }
    
    func insertData(paper:AnyObject?,flag:Int,isLike:Bool,isBookmark:Bool){
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let p = NSEntityDescription.insertNewObjectForEntityForName("Paper", inManagedObjectContext: context) as! PaperManagedObject
        
        if(flag == 1){
            
            let p1 = paper as! PaperModel
            
            p.setValue(p1.id, forKey: "document_id")
            
            p.setValue(p1.title, forKey: "title")
            
            p.setValue(p1.summary, forKey: "summary")
            
            p.setValue(p1.author, forKey: "authors")
            
            p.setValue(p1.updated, forKey: "update")
            
            p.setValue(isLike, forKey: "isLike")
            
            p.setValue(isBookmark, forKey: "isBookmark")
            
        }else{
            
            let p2 = paper as! RecommendedPaperModel
            
            p.setValue(p2.document_id, forKey: "document_id")
            
            p.setValue(p2.title, forKey: "title")
            
            p.setValue(p2.text, forKey: "summary")
            
            p.setValue(p2.authors, forKey: "authors")
            
            p.setValue(p2.date, forKey: "update")
            
            p.setValue(isLike, forKey: "isLike")
            
            p.setValue(isBookmark, forKey: "isBookmark")
            
        }
        
        
        do{try context.save()}
            
        catch{}
        
        
    }
    
    /*func deleteOneRowByIndex(index:Int){
        
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let f = NSFetchRequest(entityName: "Paper")
        
        var data:[AnyObject]
        
        do{
            
            data = try context.executeFetchRequest(f)
            
            context.deleteObject(data[index] as! NSManagedObject )
            
            do{try context.save()}
                
            catch{}
            
            
        }catch{}
        
        
    }*/
    
    func deleteOneRowByField(title:String){
        
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let f = NSFetchRequest(entityName: "Paper")
        
        f.predicate = NSPredicate(format: "title = %@", title)
        
        var data:[AnyObject]
        
        do{
            
            data = try context.executeFetchRequest(f)
            
            if data.count > 0{
                
                for d in data{
                    
                    context.deleteObject(d as! NSManagedObject )
                    
                }
                
                do{try context.save()}
                    
                catch{}
                
                
            }
            
        }catch{}
        
        
    }
    
}

extension BookmarkViewController{
    
    func findAllData() -> [PaperModel]{
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let f = NSFetchRequest(entityName: "Paper")
        
        var paper:[PaperModel]? = []
        
        do{
            
            let data = try context.executeFetchRequest(f) as NSArray
            
            for(var i=0;i<data.count;i++){
                
                let item = data[i] as! PaperManagedObject
                
                let id = item.valueForKey("document_id") as! String
                
                let author = item.valueForKey("authors") as! String
                
                let title = item.valueForKey("title") as! String
                
                let update = item.valueForKey("update") as! String
                
                let summary = item.valueForKey("summary") as! String
                
                let p = PaperModel(id:id)
                
                p.author = author
                
                p.title = title
                
                p.updated = update
                
                p.summary = summary
                
                paper?.append(p)
                
            }
            
            return paper!
            
            
            
        }catch{}
        
        return []
        
    }
    
    
    func deleteOneRowByIndex(index:Int){
        
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let f = NSFetchRequest(entityName: "Paper")
        
        var data:[AnyObject]
        
        do{
            
            data = try context.executeFetchRequest(f)
            
            context.deleteObject(data[index] as! NSManagedObject )
            
            do{try context.save()}
                
            catch{}
            
            
        }catch{}
        
        
    }

    
    
}
