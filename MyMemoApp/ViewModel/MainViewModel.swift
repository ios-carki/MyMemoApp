//
//  MainViewModel.swift
//  MyMemoApp
//
//  Created by Carki on 2022/10/31.
//

import Foundation

import RealmSwift

class MainViewModel {
    
    //#1. tasks -> Observable 객체로 변환
    var tasks: Observable<Results<Memo>?> = Observable(nil)
    let localRealm = try! Realm()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter
    }()
    
    //#2. 메서드 분리
    /*
    func fetchRealm() {
        tasks = localRealm.objects(Memo.self).sorted(byKeyPath: "regDate", ascending: true)
    }
     */
    func fetchRealm() -> Observable<Results<Memo>?> {
        tasks = Observable(localRealm.objects(Memo.self).sorted(byKeyPath: "regDate", ascending: true))
        
        return tasks
    }
    
}
