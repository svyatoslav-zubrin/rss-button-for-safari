//
//  FeedHandlerModel.swift
//  RSS Button for Safari
//
//  Created by Jan Pingel on 2018-09-28.
//  Copyright © 2018 BitPiston Studios. All rights reserved.
//

import Foundation

enum FeedHandlerType: String {
    case app = "app"
    case web = "web"
}

@objc(FeedHandlerModel)
class FeedHandlerModel: NSObject, NSCoding {    
    let title: String
    let type : FeedHandlerType
    let url  : String?
    let appId: String?
    
    init(title: String, type: FeedHandlerType, url: String?, appId: String?) {
        if (type == FeedHandlerType.app && appId == nil) || (type == FeedHandlerType.web && url == nil) {
            NSLog("Error: Invalid FeedHandlerModel (\(title))")
        }
        
        self.title = title
        self.type  = type
        self.url   = url
        self.appId = appId
        
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.type  = FeedHandlerType(rawValue: aDecoder.decodeObject(forKey: "type") as! String)!
        self.url   = aDecoder.decodeObject(forKey: "url") as? String
        self.appId = aDecoder.decodeObject(forKey: "appId") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.type.rawValue, forKey: "type")
        
        if let url = self.url {
            aCoder.encode(url, forKey: "url")
        }
        if let appId = self.appId {
            aCoder.encode(appId, forKey: "appId")
        }
    }
}