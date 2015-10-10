//
//  TagViewController.swift
//  ArxivRS
//
//  Created by zhangjun on 15/10/8.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit
import CoreData

class TagViewController: UIViewController {
    
    
    var taglist : AnyObject?
    

    @IBOutlet weak var tagShowView: UIScrollView!
    @IBOutlet weak var tagInputView: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   deleteAllData()
        
        self.tagShowView.contentSize = CGSizeMake(400,600)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addTagBtn(sender: AnyObject) {
        
        self.tagInputView.resignFirstResponder()
        
        if let inputTag = tagInputView.text{
            
            let tag : TagModel = TagModel(name: inputTag)
            
            tag.id = 1
            
            self.insertData(tag)
            
            taglist = self.findData() as! NSArray
            
            self.updateUI(taglist! as! NSArray)
            
        }
        
    }
    
    func updateUI(tags:NSArray){
        
        for(var i=0;i<tags.count;i++){
            
            let tagLabel = UILabel(frame: CGRectMake(0,CGFloat(i)*60, 100, 50))
            
            tagLabel.backgroundColor = UIColor.randomFlatColor()
            
            tagLabel.text = tags[i].valueForKey("name") as? String
            
            self.tagShowView.addSubview(tagLabel)
            
        }
    
    }
    
    func insertData(t:TagModel){
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let tag = NSEntityDescription.insertNewObjectForEntityForName("Tag", inManagedObjectContext: context)
        
        tag.setValue(t.id, forKey: "id")
        
        tag.setValue(t.name, forKey: "name")
        
        do{
            
            try context.save()
            
        }catch{
            
            
        }
        
    }

    
    func findData() -> AnyObject{
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let f = NSFetchRequest(entityName: "Tag")
        
        do{
            
            let data = try context.executeFetchRequest(f)
            
            return data
            
            
        }catch{}
        
        return 0
    
        
    }
    
    func deleteAllData(){
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let f = NSFetchRequest(entityName: "Tag")
              
    
        
        

    }

    
}
