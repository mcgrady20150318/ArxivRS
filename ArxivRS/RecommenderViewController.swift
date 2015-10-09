//
//  RecommenderViewController.swift
//  ArxivRS
//
//  Created by zhangjun on 15/10/7.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RecommenderViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var recommenderPaper : [RecommendedPaperModel] = []

    @IBOutlet weak var RecommenderTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.RecommenderTableView.dataSource = self
        self.RecommenderTableView.delegate = self
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
    
    func fetchPaperFromRemote(){
        
        let APIKey = "925238b9ec66cb7e4b2d28e1078c2d51"
        
        let url = "https://arxiv-api.lateral.io/recommend-by-text/"
        
        let headers = [
            
            "content-type" : "application/json",
            "subscription-key" : APIKey
            
        ]
        
        let parameters = [
            
            "text" : "Machine learning is a subfield of computer science that evolved from the study of pattern recognition"
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
                
                
        }
        
    }
    

    

}
