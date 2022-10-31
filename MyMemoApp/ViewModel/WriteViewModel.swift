//
//  WriteViewModel.swift
//  MyMemoApp
//
//  Created by Carki on 2022/10/31.
//

import Foundation

import RealmSwift

class WriteViewModel {
    let localRealm = try! Realm()
    
//    let realmTitle: Observable<String?> = Observable(nil)
//    let realmSubtitle: Observable<String?> = Observable(nil)
//    let realmDate = Date()
    
    //메모 안에 있는 데이터가 바뀔때마다 소통하는거니 메모 파일을 옵저버블로 채택
    let realmData: Observable<Memo?> = Observable(nil)
    
    func writeDate(data: Memo) {
        
        try! localRealm.write {
            localRealm.add(data)
        }
    }
    
    
}
