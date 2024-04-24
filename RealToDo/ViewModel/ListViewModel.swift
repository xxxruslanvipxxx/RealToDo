//
//  ToDoViewModel.swift
//  RealToDo
//
//  Created by Руслан Забиран on 14.04.24.
//

import Foundation

protocol ListViewModelProtocol {
    var tasks: [TaskDTO]? {get set}
    func reloadTasks()
    func saveTasks(tasks: [TaskDTO])
    func goToNewTaskVC()
}

class ListViewModel: ListViewModelProtocol {   // Refactor this mess
    
    private var appCoordinator: AppCoordinator
    private let taskRepository: TaskRepositoryProtocol
    
    var tasks: [TaskDTO]?
    
    init(taskRepository: TaskRepositoryProtocol, appCoordinator: AppCoordinator) {
        self.taskRepository = taskRepository
        self.appCoordinator = appCoordinator
        self.tasks = fetchTasks()
    }
    
    private func fetchTasks() -> [TaskDTO] {
        taskRepository.getAllTasks()
    }
    
    func reloadTasks() {
        self.tasks = fetchTasks()
    }
    
    func saveTasks(tasks: [TaskDTO]) {
        taskRepository.saveTasks(tasks)
    }
        
    func goToNewTaskVC() {
        appCoordinator.goToNewTaskVC()
    }
}
