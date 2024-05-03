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
    func saveTask(_ task: TaskDTO)
    func saveTasks(_ tasks: [TaskDTO])
    func deleteTask(primaryKey: String)
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
        storageService.fetch(by: TaskObject.self)
            .sorted(by: { $0.date.timeIntervalSince1970 > $1.date.timeIntervalSince1970 })
            .map { TaskDTO(object: $0) }
    }
    
    func saveTask(_ task: TaskDTO) {
        try? storageService.saveOrUpdateObject(object: TaskObject(dto: task))
    }
    
    func saveTasks(_ tasks: [TaskDTO]) {
        try? storageService.saveOrUpdateAllObjects(objects: tasks.map { TaskObject(dto: $0) })
    }
    
    func deleteTask(primaryKey: String) {
        try? storageService.delete(for: primaryKey)
    }
    
    func clearAllTasks() {
        try? storageService.deleteAll()
    }
    
    
}
