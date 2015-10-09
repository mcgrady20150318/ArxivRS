//
//  SurpriseViewController.swift
//  ArxivRS
//
//  Created by zhangjun on 15/10/7.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SurpriseViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    let identifier = "paperCell"
    
    var id : String?
    var recommenderPaper : [RecommendedPaperModel] = []
    
    @IBOutlet weak var SurpriseTableView: UITableView!
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SurpriseTableView.dataSource = self
        self.SurpriseTableView.delegate = self
        
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
        
        self.SurpriseTableView.registerNib(UINib(nibName: "PaperCell", bundle:nil), forCellReuseIdentifier: PaperCell.getCellIdentifier())
        
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
    
    func getSurpriseUrl(url:String) -> String{
        
        var a = url.componentsSeparatedByString("/")
        
        let d = a[3]
        
        let b = a[4].componentsSeparatedByString("v")[0]
        
        let c = "http://arxiv.org/\(d)/\(b)"
        
        return c
    
    }
    
    func fetchPaperFromRemote(){
        
        let APIKey = "925238b9ec66cb7e4b2d28e1078c2d51"
        
        let url = "https://arxiv-api.lateral.io/recommend-by-id/"
        
        let headers = [
            
            "content-type" : "application/json",
            "subscription-key" : APIKey
            
        ]

        
        //let documen_id = self.id?.componentsSeparatedByString("v")[0]
        
        //print(documen_id)
        
        //let document_id = "http://arxiv.org/abs/1505.03933"
        
        let document_id = getSurpriseUrl(self.id!)
        
        let parameters = [
            
            "document_id" : "arxiv-\(document_id)"
        ]
        
        Alamofire.request(.POST, url ,parameters:parameters,encoding: .JSON,headers:headers)
            
            .responseJSON{response in
                
                var json = JSON(response.2.value!)
                
                let count = json.count
                
                print(response.2.value!)
                
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
                
                self.SurpriseTableView.reloadData()
                
                
        }
        
    }
    
    
}
