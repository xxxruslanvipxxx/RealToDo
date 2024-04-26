//
//  AppCoordinator.swift
//  RealToDo
//
//  Created by Руслан Забиран on 17.04.24.
//

import Foundation
import UIKit
class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var taskRepository = TaskRepository()
    
    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
        goToListVC()
    }
    
    func goToListVC() {
        let listVC = ListViewController()
        let listVM = ListViewModel(taskRepository: taskRepository, appCoordinator: self)
        listVC.viewModel = listVM
        navigationController.pushViewController(listVC, animated: true)
    }
    
    func goToNewTaskVC() {
        let newTaskVC = TaskViewController()
        let newTaskVM = TaskViewModel(appCoordinator: self, taskRepository: taskRepository)
        newTaskVC.viewModel = newTaskVM
        navigationController.pushViewController(newTaskVC, animated: true)
    }
    
    func goToEditTaskVC(task: TaskDTO) {
        let editTaskVC = TaskViewController()
        let editTaskVM = TaskViewModel(appCoordinator: self, taskRepository: taskRepository)
        editTaskVC.viewModel = editTaskVM
        editTaskVM.task = task
        navigationController.pushViewController(editTaskVC, animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
}
