//
//  TagViewController.swift
//  ArxivRS
//
//  Created by zhangjun on 15/10/8.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit
import CoreData


class TagViewController: UIViewController,ZFTokenFieldDataSource,ZFTokenFieldDelegate{
    
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var tokenField: ZFTokenField!
    
    var tokens:[TagModel]? = []
    
   // var tokens:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tokenField.dataSource = self
        self.tokenField.delegate = self
        self.tokenField.textField.placeholder = "Enter here..."
        
        self.tokens = self.findAllData()
        
        self.insertData(TagModel(name:"bbb"))
        
     //   for token in self.tokens!{
            
     //       print(token.name)
     //   }
        self.tokenField.reloadData()
        
        let screen = UIScreen.mainScreen().bounds
        self.scroll.contentSize = CGSizeMake(screen.width - 20, self.scroll.frame.height + 100)
        self.tokenField.textField.becomeFirstResponder()
        
    }
    
    

    
    func tokenDeleteButtonPressed(tokenButton:UIButton){
    
        if let index:Int = self.tokenField.indexOfTokenView(tokenButton.superview){
            
            self.tokens?.removeAtIndex(index)
            
            self.deleteOneRowByIndex(index)
            
            self.tokenField.reloadData()
            
        }

    }
    
    /*
        
        DataSource
    
    */

    func lineHeightForTokenInField(tokenField:ZFTokenField) -> CGFloat{
        
        return 40
        
    }

    func numberOfTokenInField(tokenField:ZFTokenField)->Int{
        
        return self.tokens!.count
    }
    
    func tokenField(tokenField: ZFTokenField!, viewForTokenAtIndex index: Int) -> UIView! {
        
        let nibContents:NSArray = NSBundle.mainBundle().loadNibNamed("TokenView", owner: nil, options: nil)
        
        let view:UIView = nibContents[0] as! UIView
        
        let label:UILabel = view.viewWithTag(2) as! UILabel
        
        let button:UIButton = view.viewWithTag(3) as! UIButton
        
        button.addTarget(self, action: "tokenDeleteButtonPressed:", forControlEvents:UIControlEvents.TouchUpInside)
        
        label.text = self.tokens![index].name
        
        label.backgroundColor = UIColor.randomFlatColor()
        
        let size:CGSize = label.sizeThatFits(CGSizeMake(1000, 40))
        
        view.frame = CGRectMake(0, 0, size.width + 97, 40)
        
        return view
        
    
    }
    
    /*
    
        Delegate
    
    */
    
    func tokenMarginInTokenInField(tokenField: ZFTokenField!) -> CGFloat {
        
        return 5
    }
    
    func tokenField(tokenField: ZFTokenField!, didReturnWithText text: String!) {
        
        self.tokens!.append(TagModel(name:text))
        
        self.insertData(TagModel(name:text))
        
        self.tokenField.reloadData()
        
    }
    
    func tokenField(tokenField: ZFTokenField!, didRemoveTokenAtIndex index: Int) {
        
        self.deleteOneRowByIndex(index)
    
        self.tokens!.removeAtIndex(index)
        
    }
    
    func tokenFieldShouldEndEditing(textField: ZFTokenField!) -> Bool {
        
        return false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    



}

