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
class ListViewController: UIViewController {
    
    var viewModel: ListViewModelProtocol?
    var safeArea: UILayoutGuide!
    var tasks: [TaskDTO]?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: CellIdentifier.taskCell.rawValue)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getTasks()
        tableView.reloadData()
    }
    
    private func getTasks() {
        let tasks = viewModel?.fetchTasks()
        self.tasks = tasks
    }
    

}
//MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getTaskCount() ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.taskCell.rawValue, for: indexPath) as? TaskCell {
            guard let task = tasks?[indexPath.row] else { return cell }
            
            cell.mainLabel.text = task.mainText
            cell.additionalLabel.text = task.additionalText ?? ""
            cell.checkBox.isChecked = task.isCompleted
            
            let formatter = DateFormatter()
            formatter.dateFormat = "d.MM.y"
            cell.dateLabel.text = formatter.string(from: task.date)
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}

//MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

//MARK: - UI Setup

extension ListViewController {
    
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
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        
    }
    
    @objc func addTapped() {
        viewModel?.goToNewTaskVC()
    }
    
}
