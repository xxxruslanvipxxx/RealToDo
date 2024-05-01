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
    func deleteTask(_ index: Int)
    func saveOrUpdateTask(task: TaskDTO)
    func goToNewTaskVC()
    func goToEditTaskVC(task: TaskDTO)
}

class ListViewModel: ListViewModelProtocol {
    
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
    
    func deleteTask(_ index: Int) {
        guard let deletedTask = self.tasks?.remove(at: index) else { return }
        let key = deletedTask.id
        taskRepository.deleteTask(primaryKey: key)
    }
    
    func saveOrUpdateTask(task: TaskDTO) {
        taskRepository.saveTask(task)
        reloadTasks()
    }
    
    func goToNewTaskVC() {
        appCoordinator.goToNewTaskVC()
    }
    
    func goToEditTaskVC(task: TaskDTO) {
        appCoordinator.goToEditTaskVC(task: task)
    }
    
}
