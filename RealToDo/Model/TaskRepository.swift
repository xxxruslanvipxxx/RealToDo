//
//  TaskRepository.swift
//  RealToDo
//
//  Created by Руслан Забиран on 15.04.24.
//

import Foundation

//MARK: - TaskRepositoryProtocol

protocol TaskRepositoryProtocol {
    func getAllTasks() -> [TaskDTO]
    func saveTasks(_ tasks: [TaskDTO])
    func clearAllTasks()
}
//MARK: - TaskRepository

final class TaskRepository: TaskRepositoryProtocol {
    
    //MARK: StorageService
    
    var storageService: StorageService
    
    //MARK: Initializer
    
    init(storageService: StorageService = StorageService()) {
        self.storageService = storageService
    }
    
    func getAllTasks() -> [TaskDTO] {
        storageService.fetch(by: TaskObject.self).map { TaskDTO(object: $0) }
    }
    
    func saveTasks(_ tasks: [TaskDTO]) {
        try? storageService.saveOrUpdateAllObjects(objects: tasks.map { TaskObject(dto: $0) })
    }
    
    func clearAllTasks() {
        try? storageService.deleteAll()
    }
    
    
}
