//
//  Memo.swift
//  MyMemoApp
//
//  Created by Carki on 2022/10/31.
//

import Foundation

import RealmSwift

class Memo: Object {
    
    @Persisted var title: String
    @Persisted var detail: String
    @Persisted var regDate = Date()
    
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(title: String, detail: String, regDate: Date) {
        self.init()
        self.title = title
        self.detail = detail
        self.regDate = regDate
    }
}
