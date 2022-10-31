//
//  MemoMainView.swift
//  MyMemoApp
//
//  Created by Carki on 2022/10/31.
//

import UIKit

import SnapKit

class MemoMainView: BaseView {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        
        return view
    }()
    
    let tableView:UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .gray
        return view
    }()
    
    let testButton: UIButton = {
        let view = UIButton()
        view.setTitle("메모작성하기", for: .normal)
        view.backgroundColor = .white
        view.setTitleColor(UIColor.black, for: .normal)
        return view
    }()
    
    override func configureUI() {
        [searchBar, testButton, tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        testButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }
}
