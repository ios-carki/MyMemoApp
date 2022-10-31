//
//  MemoWriteViewController.swift
//  MyMemoApp
//
//  Created by Carki on 2022/10/31.
//

import UIKit

import RealmSwift

class MemoWriteViewController: BaseViewController {
    
    let mainView = MemoWriteView()
    let viewModel = WriteViewModel()
    
    let localRealm = try! Realm()
    
    override func loadView() {
        view = mainView
        view.backgroundColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButtonClikced()
        naviSetting()
        viewModel.realmData.bind { value in
            
        }
    }
    
    func naviSetting() {
        let backButton = UIBarButtonItem(title: "뒤로가기", style: .plain, target: self, action: #selector(backButtonAction))
        
        self.navigationController?.navigationBar.barTintColor = .black
        //self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.backBarButtonItem = backButton
    }
    
    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveButtonClikced() {
        mainView.saveButton.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
    }
    
    @objc func saveButton() {
        var memoText = mainView.mainTextView.text!
        var memoTextIndexCounter = 0
        
        if let returnRange = memoText.range(of: "\n") {
            memoTextIndexCounter = memoText.distance(from: memoText.startIndex, to: returnRange.lowerBound)
        }
        
        let startingIndex = 0
        let endingIndex = memoTextIndexCounter
        
        let startIndex = memoText.index(memoText.startIndex, offsetBy: startingIndex)// 사용자지정 시작인덱스
        let endIndex = memoText.index(memoText.startIndex, offsetBy: endingIndex)
        let endIndexForDetail = memoText.index(memoText.startIndex, offsetBy: endingIndex + 1)// 사용자지정 끝인덱스
        var memoTitle = memoText[startIndex ..< endIndex]
        var memoDetail = memoText[endIndexForDetail ..< memoText.endIndex]
        print(" 타이틀: \(memoTitle), 타입: \(type(of: memoTitle))")
        print(" 디테일: \(memoDetail)")
        
        let task = Memo(title: String(memoTitle), detail: String(memoDetail), regDate: Date())
        
//        try! localRealm.write {
//            localRealm.add(task)
//            print("저장완료")
//            self.navigationController?.popViewController(animated: true)
//        }
        viewModel.writeDate(data: task)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
