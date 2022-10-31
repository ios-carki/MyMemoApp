//
//  MemoMainViewController.swift
//  MyMemoApp
//
//  Created by Carki on 2022/10/31.
//

import UIKit

import RealmSwift

class MemoMainViewController: BaseViewController {
    
    let mainView = MemoMainView()
    
    let localRealm = try! Realm()
    var tasks: Results<Memo>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter
    }()
    
    override func loadView() {
        view = mainView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
        tableSetting()
        startWirte()
        fetchRealm()
        naviSetting()
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
        
        self.title = "\(tasks.count)개의 메모"
    }
    
    func fetchRealm() {
        tasks = localRealm.objects(Memo.self).sorted(byKeyPath: "regDate", ascending: true)
    }
    
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
        
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MemoWriteViewController()
        
        //vc.mainView.saveButton.setTitle("수정하기", for: .normal)
        vc.mainView.mainTextView.text = "\(tasks[indexPath.row].title)" + "\n" + "\(tasks[indexPath.row].detail)"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = tasks[indexPath.row].title
        cell.detailTextLabel?.text = "\(tasks[indexPath.row].detail)" + " - " + "\(dateFormatter.string(from: tasks[indexPath.row].regDate))" + "에 작성됨."
        print(cell.detailTextLabel?.text)
        
        return cell
    }
    
    
}
