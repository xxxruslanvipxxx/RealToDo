//
//  ToDoViewModel.swift
//  RealToDo
//
//  Created by Руслан Забиран on 14.04.24.
//

import Foundation

protocol ListViewModelProtocol {
    func fetchTasks() -> [TaskDTO]
    func saveTasks(tasks: [TaskDTO])
    func goToNewTaskVC()
}

class ListViewModel: ListViewModelProtocol {
    
    private var appCoordinator: AppCoordinator
    
    private let taskRepository: TaskRepositoryProtocol
    
    init(taskRepository: TaskRepositoryProtocol, appCoordinator: AppCoordinator) {
        self.taskRepository = taskRepository
        self.appCoordinator = appCoordinator
    }
    
    func fetchTasks() -> [TaskDTO] {
        taskRepository.getAllTasks()
    }
    
    func saveTasks(tasks: [TaskDTO]) {
        taskRepository.saveTasks(tasks)
    }
    
    func goToNewTaskVC() {
        appCoordinator.goToNewTaskVC()
    }
}
