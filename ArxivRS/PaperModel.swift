//
//  PaperModel.swift
//  
//
//  Created by zhangjun on 15/10/7.
//
//

import UIKit

class PaperModel: NSObject {
    
    var id : String?
    
    var updated : String?
    
    var published : String?
    
    var title : String?
    
    var summary : String?
    
    var author : String?
    
    var category : [String]?
    
    init(id : String){
        
        self.id = id
    }
    
}
