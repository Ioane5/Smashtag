//
//  RecentsStore.swift
//  Smashtag
//
//  Created by Ioane Sharvadze on 11/27/15.
//  Copyright © 2015 Ioane Sharvadze. All rights reserved.
//

import Foundation


class RecentsStore {

    private static var recents = [String]() {
        didSet {
            if let savedRecents = NSUserDefaults.standardUserDefaults().stringArrayForKey("recents") {
                recents += savedRecents
            }
        }
    }
    
    static func addSearch(search:String) {
        recents.insert(search, atIndex: 0)
        if recents.count > 100 {
            recents.removeLast()
        }
    }
    
    static func getSize() -> Int{
        return recents.count
    }
    
    static func getSearchAt(index :Int) -> String {
        return recents[index]
    }
    
    static func saveToDisk() {
        NSUserDefaults.standardUserDefaults().setValue(recents, forKey: "recents")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}