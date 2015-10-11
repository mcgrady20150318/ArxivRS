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
    @IBOutlet weak var Selector: UISegmentedControl!
    
    var searchPaper : [PaperModel] = []
    
    var indicator: PendulumView?
    
    var alertView : DXAlertView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.PaperTableView.registerNib(UINib(nibName: "PaperCell", bundle:nil), forCellReuseIdentifier: identifier)
        self.PaperTableView.dataSource = self
        self.PaperTableView.delegate = self
        self.Selector.selectedSegmentIndex = 1 // default selected in author type
        //self.navigationController?.navigationBar.backgroundColor = UIColor.flatDarkPurpleColor()
        //self.navigationController?.navigationBar.alpha = 0.5
        self.alertView = DXAlertView.init(title: "Sorry", contentText: "can't connect the host", leftButtonTitle: "ok", rightButtonTitle: "cancel")
       // self.alertView?.show()
        
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
        
        var keywords = Input.text
        
        var type:String = ""
        
        let searchType: Int = Selector.selectedSegmentIndex
        
        switch searchType{
            
        case 0:
            
            type = "id:"
            
        case 1:
            
            type = "au:"
            
        case 2:
            
            type = "ti:"
            
        case 3:
            
            type = "abs:"
            
        default:
            
            break
            
        }
        
        self.indicator = PendulumView.init(frame: self.view.bounds, ballColor:UIColor.blueColor())
        
        self.view.addSubview(self.indicator!)
        
        self.indicator!.startAnimating()
        
        keywords = "\(type)\(keywords!)"
        
        self.fetchPaperFromRemote(keywords!)
        
        self.Input.resignFirstResponder()
    
    }
    

    func fetchPaperFromRemote(keywords : String){
        
        let space = NSCharacterSet.whitespaceAndNewlineCharacterSet()
        
        let keyword = keywords.stringByTrimmingCharactersInSet(space)

        let url = "http://arxivwrap.org/wrapper?method=json&search_query=\(keyword)&max_results=50"//au:bengio
        
    do{
            
        try Alamofire.request(.GET, url).responseJSON { response in
            
            var result = JSON(response.2.value!)
            
            self.searchPaper.removeAll() //  remove all data before
            
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
            
            self.indicator!.stopAnimating()
            
            self.indicator!.hidesWhenStopped = true
            
            
        }
        
    }catch{
        
        self.alertView?.show()
        
        
    }
        
        
        
        
    }
    

    

}
