//
//  SearchRecordModel.swift
//  SearchWikipedia
//
//  Created by nolbal_dayeon on 2020/06/30.
//  Copyright © 2020 dayeonJung. All rights reserved.
//


import RealmSwift

class SearchRecordModel : Object {
    
    @objc dynamic var date = Date()
    @objc dynamic var searchingWord = ""
    

    required init() {

    }
    
}
