//
//  RecommenderViewController.swift
//  ArxivRS
//
//  Created by zhangjun on 15/10/7.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class RecommenderViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var recommenderPaper : [RecommendedPaperModel] = []
    
    let refresh = UIRefreshControl()

    @IBOutlet weak var RecommenderTableView: UITableView!
    
    var indicator: PendulumView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh.addTarget(self, action: "fetchPaperFromRemote", forControlEvents: UIControlEvents.ValueChanged)
        refresh.attributedTitle = NSAttributedString(string: "Pull To Refresh Paper")
        self.RecommenderTableView.addSubview(refresh)
        
        self.RecommenderTableView.dataSource = self
        self.RecommenderTableView.delegate = self
        
        self.indicator = PendulumView.init(frame: self.view.bounds, ballColor:UIColor.blueColor())
        
        self.view.addSubview(self.indicator!)
        
        self.indicator!.startAnimating()
        
        fetchPaperFromRemote()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return recommenderPaper.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        self.RecommenderTableView.registerNib(UINib(nibName: "PaperCell", bundle:nil), forCellReuseIdentifier: PaperCell.getCellIdentifier())
        
        let cell = tableView.dequeueReusableCellWithIdentifier(PaperCell.getCellIdentifier()) as! PaperCell
        
        let paper = recommenderPaper[indexPath.row] as RecommendedPaperModel!
        
        cell.RecommenderPaperCellUIShow(paper)
        
        return cell
        
    }
    
    /*
    
    Delegate
    
    */
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        let paperVC = PaperViewController(nibName: "PaperViewController", bundle: nil)
        
        paperVC.flag = 0
        
        paperVC.recommender = self.recommenderPaper[indexPath.row]
        
        self.navigationController!.pushViewController(paperVC, animated: true)

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return PaperCell.getHeightOfRow()
    }
    
    func getTagsFromCoreData() -> String{
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let f = NSFetchRequest(entityName: "Tag")
        
        do{
            
            var str = ""
            
            let data = try context.executeFetchRequest(f) as NSArray
            
            for(var i=0;i<data.count;i++){
                
                str.appendContentsOf(" ")
                
                str.appendContentsOf((data[i].valueForKey("name") as! String))
                
            }
            
            return str
            
            
        }catch{}
        
        return ""
        
        
    }
    
    func fetchPaperFromRemote(){
        
        let APIKey = "925238b9ec66cb7e4b2d28e1078c2d51"
        
        let url = "https://arxiv-api.lateral.io/recommend-by-text/"
        
        let headers = [
            
            "content-type" : "application/json",
            "subscription-key" : APIKey
            
        ]
        
        var text = self.getTagsFromCoreData()
        
        if text == ""{
            
            text = "Machine learning is a subfield of computer science that evolved from the study of pattern recognition"
            
        }
        
     //   print(text)
        
        let parameters = [
            
            "text" : text
            //"Machine learning is a subfield of computer science that evolved from the study of pattern recognition"
            ]
        
        Alamofire.request(.POST, url ,parameters:parameters,encoding: .JSON,headers:headers)
            
            .responseJSON{response in
                
                var json = JSON(response.2.value!)
                
                let count = json.count
                
                for(var i=0;i<count;i++){
                    
                    let recommender = RecommendedPaperModel(document_id:"")
                    
                    recommender.distance  = json[i]["distance"].stringValue
                    
                    recommender.authors = json[i]["authors"][0].stringValue
                    
                    recommender.title = json[i]["title"].stringValue
                    
                    recommender.text = json[i]["text"].stringValue
                    
                    recommender.date = json[i]["date"].stringValue
                    
                    recommender.document_id = json[i]["document_id"].stringValue
                    
                    recommender.url = json[i]["url"].stringValue
                    
                    self.recommenderPaper.append(recommender)
                    
                }
                
                self.RecommenderTableView.reloadData()
                
                self.indicator!.stopAnimating()
                
                self.indicator?.hidesWhenStopped = true
                
                
        }
        
        self.refresh.endRefreshing()
        
    }
    

    

}
