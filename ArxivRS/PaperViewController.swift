//
//  PaperViewController.swift
//  ArxivRS
//
//  Created by zhangjun on 15/10/7.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit

class PaperViewController: UIViewController {
    
    var flag : Int = 0
    
    var paper = PaperModel(id : "")
    
    var recommender = RecommendedPaperModel(document_id : "")

    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var Sview: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var bookmarkBtn: UIButton!
    
    var isLikeBtnClicked:Bool?
    
    var isBookMarkBtnClicked:Bool?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isLikeBtnClicked = false
        
        self.isBookMarkBtnClicked = false
        
        let screenRect:CGRect = UIScreen.mainScreen().bounds
        
        self.Sview.contentSize = CGSizeMake(screenRect.width, screenRect.height + 200)
        
        self.view.backgroundColor = UIColor.flatDarkBlueColor()
        
       // self.summary.contentSize = CGSizeMake(screenRect.width, 1200.0)
        
        //self.summary
        
        //self.summary.contentSize = CGSizeMake(screenRect.width, screenRect.height + 50)
        
        self.title = "PaperDetail"
    
        if flag == 1 {
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Surprise", style: UIBarButtonItemStyle.Plain, target: self, action: "surprise:")
            
            titleLabel.text = paper.title
            
            authorLabel.text = paper.author
            
            updatedLabel.text = paper.updated
            
            summary.text = paper.summary
            
        }else{
            
            titleLabel.text = recommender.title
            
            authorLabel.text = recommender.authors
            
            updatedLabel.text = recommender.date
            
            summary.text = recommender.text
            
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickLikeBtn(sender: AnyObject) {
        
        //execute network callback 
        
        //insert a record in the table of cloud
        
        //to record the user's callback for recommendation and user's behavior
        
        //record including the arxivid and clickState
        
        if(self.isLikeBtnClicked == false){
            
            self.likeBtn.setImage(UIImage(named: "OnLike"), forState: UIControlState.Normal)
            
            self.isLikeBtnClicked = true
            
            
        }else{
            
            self.likeBtn.setImage(UIImage(named: "OffLike"), forState: UIControlState.Normal)
            
            self.isLikeBtnClicked = false
            
        }
        
        
    }
    
    
    @IBAction func clickBookmarkBtn(sender: AnyObject) {
        
        //network callback and local CoreData callback
        
        //badge show in Bookmark viewcontroller
        
        if(self.isBookMarkBtnClicked == false){
            
            self.bookmarkBtn.setImage(UIImage(named: "OnBookmark"), forState: UIControlState.Normal)
            
            self.isBookMarkBtnClicked = true
            
            // local CoreData
            if(flag == 1){
                
                self.insertData(paper, flag: flag)
                
                
            }else{
                
                self.insertData(recommender, flag: flag)
            }
            
            
            // add badge in BookmarkViewController
            
            
            
            
            
        }else{
            
            self.bookmarkBtn.setImage(UIImage(named: "OffBookmark"), forState: UIControlState.Normal)
            
            self.isBookMarkBtnClicked = false
            
            if(flag == 1){
                
                self.deleteOneRowByField(paper.title!)
                
            }else{
                
                self.deleteOneRowByField(recommender.title!)
            }
            
            // add badge in BookmarkViewController
            
            
            
            
        }

    }
    
    
    
    func surprise(sender:AnyObject){
        
        let surpriseVC = SurpriseViewController(nibName: "SurpriseViewController", bundle: nil)
        
        surpriseVC.id = paper.id
        
        self.navigationController?.pushViewController(surpriseVC, animated: true)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
