//
//  NewTaskViewModel.swift
//  RealToDo
//
//  Created by Руслан Забиран on 17.04.24.
//

import Foundation

protocol TaskViewModelProtocol {
    func goToListVC()
}

class TaskViewModel: TaskViewModelProtocol {
    
    var appCoordinator: AppCoordinator
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func goToListVC() {
        appCoordinator.goToListVC()
    }
}
