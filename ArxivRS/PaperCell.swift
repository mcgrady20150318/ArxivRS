//
//  PaperCell.swift
//  ArxivRS
//
//  Created by zhangjun on 15/10/7.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit

class PaperCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var updated: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.flatDarkTealColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func getCellIdentifier() -> String{
    
        return "paperCell"
    
    }
    
    class func getHeightOfRow() -> CGFloat{
        
        return 120.0
    }
    
    // cell show functions
    
    func SearchPaperCellUIShow(paper:PaperModel){
        
        self.title.text = paper.title!
        
        self.author.text = paper.author!
        
        self.updated.text = paper.updated!
        
    }
    
    func RecommenderPaperCellUIShow(paper:RecommendedPaperModel){
        
        self.title.text = paper.title
        
        self.author.text = paper.authors
        
        self.updated.text = paper.date
        
    }
    
    
}
