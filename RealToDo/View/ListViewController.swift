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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: CellIdentifier.taskCell.rawValue)
        tableView.accessibilityIdentifier = "ListTableView"
        
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
        reloadTasksFromDB()
        tableView.reloadData()
    }
    
    private func reloadTasksFromDB() {
        viewModel?.reloadTasks()
    }
    

}

//MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.tasks?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.taskCell.rawValue, for: indexPath) as? TaskCell {
            guard let task = self.viewModel?.tasks?[indexPath.row] else { return cell }
            
            cell.mainLabel.text = task.mainText
            cell.additionalLabel.text = task.additionalText ?? ""
            cell.checkBox.isChecked = task.isCompleted
            cell.accessibilityIdentifier = "cell_\(indexPath.row)"
            cell.checkBox.isCheckedChanged = { [weak self] in
                var task = task
                task.isCompleted = cell.checkBox.isChecked
                self?.viewModel?.saveOrUpdateTask(task: task)
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "d.MM.y"
            cell.dateLabel.text = formatter.string(from: task.date)
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.deleteTask(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}

//MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let task = viewModel?.tasks?[indexPath.row] else { return }
        viewModel?.goToEditTaskVC(task: task)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 10, 0)
        cell.layer.transform = transform
        cell.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
            
        }
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
        let barButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        barButtonItem.accessibilityIdentifier = "Add"
        navigationItem.rightBarButtonItem = barButtonItem
        
    }
    
    @objc func addTapped() {
        viewModel?.goToNewTaskVC()
    }
    
}
