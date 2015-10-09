//
//  SearchViewController.swift
//  ArxivRS
//
//  Created by zhangjun on 15/10/7.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var Input: UITextField!
    @IBOutlet weak var PaperTableView: UITableView!
    
    var searchPaper : [PaperModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.PaperTableView.registerNib(UINib(nibName: "PaperCell", bundle:nil), forCellReuseIdentifier: identifier)
        self.PaperTableView.dataSource = self
        self.PaperTableView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* 
    
    Data Source 
    
    
    */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return searchPaper.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        self.PaperTableView.registerNib(UINib(nibName: "PaperCell", bundle:nil), forCellReuseIdentifier:PaperCell.getCellIdentifier())
        
        let cell = tableView.dequeueReusableCellWithIdentifier(PaperCell.getCellIdentifier()) as! PaperCell
    
        let paper = searchPaper[indexPath.row] as PaperModel!
        
        cell.SearchPaperCellUIShow(paper)
        
        return cell
        
    }
    
    /*
    
        Delegate
    
    */
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        let paperVC = PaperViewController(nibName: "PaperViewController", bundle: nil)
       
        paperVC.flag = 1
        
        paperVC.paper = self.searchPaper[indexPath.row]
        
        self.navigationController!.pushViewController(paperVC, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return PaperCell.getHeightOfRow()
    }
    
    
    
    /*
    
        Go Button
    
    */
    
    @IBAction func GoBtn(sender: AnyObject) {
        
        let keywords = Input.text
        
        self.fetchPaperFromRemote(keywords!)
        
        Input.resignFirstResponder()
        
        
    }
    

    func fetchPaperFromRemote(keywords : String){
        
        let url = "http://arxivwrap.org/wrapper?method=json&search_query=\(keywords)&max_results=20"//au:bengio
        
        Alamofire.request(.GET, url).responseJSON { response in
            
            var result = JSON(response.2.value!)
            
            for(var i=0;i<result.count;i++){
                
                let paper : PaperModel = PaperModel(id:"")
                
                paper.id = result["entries"][i]["id"]["value"].stringValue
                
                paper.title = result["entries"][i]["title"]["value"].stringValue
                
                paper.updated = result["entries"][i]["updated"]["value"].stringValue
                
                paper.published = result["entries"][i]["published"]["value"].stringValue
                
                paper.summary = result["entries"][i]["summary"]["value"].stringValue
                
                paper.author = result["entries"][i]["author"]["value"][0]["name"]["value"].stringValue
                
                //paper.category = result["entries"][i]["category"]
                
                self.searchPaper.append(paper)
                
                
            }
            
            self.PaperTableView.reloadData()
            
          //  print(self.searchPaper)
        
            
            
            
        }
        
        
    }
    

    

}
