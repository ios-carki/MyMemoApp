//
//  MemoWriteView.swift
//  MyMemoApp
//
//  Created by Carki on 2022/10/31.
//

import UIKit

import SnapKit

class MemoWriteView: BaseView {
    
    let mainTextView: UITextView = {
        let view = UITextView()
        
        return view
    }()
    
    let saveButton: UIButton = {
        let view = UIButton()
        view.setTitle("저장", for: .normal)
        view.backgroundColor = .black
        return view
    }()
    
    override func configureUI() {
        [mainTextView, saveButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        mainTextView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(mainTextView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }
}
