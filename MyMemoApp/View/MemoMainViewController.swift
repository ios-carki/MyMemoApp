//
//  MemoMainViewController.swift
//  MyMemoApp
//
//  Created by Carki on 2022/10/31.
//

import UIKit

import RealmSwift

final class MemoMainViewController: BaseViewController {
    
    let mainView = MemoMainView()
    let viewModel = MainViewModel()
    
    let localRealm = try! Realm()
    var tasks: Results<Memo>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        view = mainView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
        tableSetting()
        startWirte()
        viewModel.fetchRealm()//fetchRealm()
        naviSetting()
        
        viewModel.tasks.bind { vlaue in
            self.mainView.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainView.tableView.reloadData()
        
        naviSetting()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = "뒤로가기"
    }
    
    func naviSetting() {
        navigationController?.navigationBar.prefersLargeTitles = true
        //navigationItem.largeTitleDisplayMode = .never
        
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        //self.title = "\(tasks.count)개의 메모"
        self.title = "\((viewModel.tasks.value?.count)!)" + "개의 메모"
    }
    /*
    func fetchRealm() {
        tasks = localRealm.objects(Memo.self).sorted(byKeyPath: "regDate", ascending: true)
    }
    */
    
    func startWirte() {
        mainView.testButton.addTarget(self, action: #selector(writeButtonClicked), for: .touchUpInside)
    }
    
    @objc func writeButtonClicked() {
        let vc = MemoWriteViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableSetting() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.rowHeight = 70
        
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
}

extension MemoMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return tasks.count
        return viewModel.tasks.value?.count ?? 0 // (viewModel.tasks.value?.count)! -> 바인딩
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MemoWriteViewController()
        
        //vc.mainView.saveButton.setTitle("수정하기", for: .normal)
        //vc.mainView.mainTextView.text = "\(tasks[indexPath.row].title)" + "\n" + "\(tasks[indexPath.row].detail)"
        
        //"\(viewModel.tasks.value![indexPath.row].title)" + "\n" + "\(viewModel.tasks.value![indexPath.row].detail)" => 바인딩
        vc.mainView.mainTextView.text = "\(viewModel.tasks.value?[indexPath.row].title)" + "\n" + "\(viewModel.tasks.value?[indexPath.row].detail)"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
//        cell.textLabel?.text = tasks[indexPath.row].title
//        cell.detailTextLabel?.text = "\(tasks[indexPath.row].detail)" + " - " + "\(viewModel.dateFormatter.string(from: tasks[indexPath.row].regDate))" + "에 작성됨."
        cell.textLabel?.text = viewModel.tasks.value?[indexPath.row].title
        cell.detailTextLabel?.text = "\(viewModel.tasks.value?[indexPath.row].detail ?? "")" + " - " + "\(viewModel.dateFormatter.string(from: viewModel.tasks.value?[indexPath.row].regDate ?? Date()))" // tasks[indexPath.row].regDate))" + "에 작성됨."
        
        return cell
    }
    
    
}
