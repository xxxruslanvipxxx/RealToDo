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
    
    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
        goToListVC()
    }
    
    func goToListVC() {
        let listVC = ListViewController()
        let taskRepository = TaskRepository()
        let listVM = ListViewModel(taskRepository: taskRepository, appCoordinator: self)
        listVC.viewModel = listVM
        navigationController.pushViewController(listVC, animated: true)
    }
    
    func goToNewTaskVC() {
        let newTaskVC = TaskViewController()
        let newTaskVM = TaskViewModel(appCoordinator: self)
        newTaskVC.viewModel = newTaskVM
        navigationController.pushViewController(newTaskVC, animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
}
