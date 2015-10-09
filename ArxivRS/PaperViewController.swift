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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    @IBOutlet weak var summaryView: UITextView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "PaperDetail"
    
        if flag == 1 {
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Surprise", style: UIBarButtonItemStyle.Plain, target: self, action: "surprise:")
            
            titleLabel.text = paper.title
            
            authorLabel.text = paper.author
            
            updatedLabel.text = paper.updated
            
            summaryView.text = paper.summary
            
        }else{
            
            titleLabel.text = recommender.title
            
            authorLabel.text = recommender.authors
            
            updatedLabel.text = recommender.date
            
            summaryView.text = recommender.text
            
        }
        
        

        // Do any additional setup after loading the view.
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
