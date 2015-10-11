//
//  BookmarkViewController.swift
//  ArxivRS
//
//  Created by zhangjun on 15/10/8.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit

class BookmarkViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    var Paper : [PaperModel] = []
    
    let refresh = UIRefreshControl()
    
    @IBOutlet weak var BookmarkTableView: UITableView!
    
    var indicator: PendulumView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*pull to refresh*/
        
        refresh.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        
        refresh.attributedTitle = NSAttributedString(string: "Pull To Refresh Paper")
        
        self.BookmarkTableView.addSubview(refresh)
        
        self.BookmarkTableView.dataSource = self
        self.BookmarkTableView.delegate = self
        
        self.indicator = PendulumView.init(frame: self.view.bounds, ballColor:UIColor.blueColor())
        
        self.view.addSubview(self.indicator!)
        
        self.indicator!.startAnimating()
        
        self.refreshData()
        
        self.indicator?.stopAnimating()
        
        self.indicator?.hidesWhenStopped = true
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshData(){
        
        self.Paper = self.findAllData()
        
        self.BookmarkTableView.reloadData()
        
        self.refresh.endRefreshing()
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return Paper.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        self.BookmarkTableView.registerNib(UINib(nibName: "PaperCell", bundle:nil), forCellReuseIdentifier: PaperCell.getCellIdentifier())
        
        let cell = tableView.dequeueReusableCellWithIdentifier(PaperCell.getCellIdentifier()) as! PaperCell
        
        let paper = Paper[indexPath.row] as PaperModel!
        
        cell.SearchPaperCellUIShow(paper)
        
        return cell
        
    }
    
    /*
    
    Delegate
    
    */
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        let paperVC = PaperViewController(nibName: "PaperViewController", bundle: nil)
        
        paperVC.flag = 1
        
        paperVC.paper = self.Paper[indexPath.row]
        
        self.navigationController!.pushViewController(paperVC, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return PaperCell.getHeightOfRow()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        self.deleteOneRowByIndex(indexPath.row)
        
        self.refreshData()

        
        
    }



    

}
