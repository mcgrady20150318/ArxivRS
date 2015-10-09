//
//  RecommendedPaperModel.swift
//  
//
//  Created by zhangjun on 15/10/7.
//
//

import UIKit

class RecommendedPaperModel: NSObject {
    
    var distance : String?
    
    var authors : String?
    
    var title : String?
    
    var text : String?
    
    var date : String?
    
    var document_id : String?
    
    var url : String?
    
    init(document_id : String){
        
        self.document_id = document_id
    
    }

}
