//
//  ViewController.swift
//  RealToDo
//
//  Created by Руслан Забиран on 14.04.24.
//

import UIKit

//MARK: - CellIdentifier
enum CellIdentifier: String {
    case taskCell
}

//MARK: - ToDoViewController
class ToDoViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: CellIdentifier.taskCell.rawValue)
        
        return tableView
    }()
    
    var safeArea: UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
    }

    

}
//MARK: - UITableViewDataSource
extension ToDoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.taskCell.rawValue, for: indexPath) as? TaskCell {
            return cell
        }
        return UITableViewCell()
    }
    
    
}

//MARK: - UITableViewDelegate

extension ToDoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

//MARK: - UI Setup

extension ToDoViewController {
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        safeArea = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
                                     tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
                                     tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor)])
      }
    
    func setupView() {
        view.backgroundColor = .white
    }
    
}
