//
//  Stream.swift
//  OnLooker
//
//  Created by Jal Irani on 9/14/19.
//  Copyright © 2019 Jal Irani. All rights reserved.
//

import Foundation
import Firebase

struct Stream {
    
    let ref: DatabaseReference?
    let key: String
    let name: String
    let type: String
    let url: String
    let active: Bool
    let lastViewed: String
    
    init(key: String = "", name: String, type: String, url: String, active: Bool, lastViewed: String) {
        self.ref = nil
        self.key = key
        self.name = name
        self.type = type
        self.url = url
        self.active = active
        self.lastViewed = lastViewed
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let type = value["type"] as? String,
            let url = value["url"] as? String,
            let active = value["active"] as? Bool,
            let lastViewed = value["lastViewed"] as? String
            else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.type = type
        self.url = url
        self.active = active
        self.lastViewed = lastViewed
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name
        ]
    }
}

//Test change for branch
