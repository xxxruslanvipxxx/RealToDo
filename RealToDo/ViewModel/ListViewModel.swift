//
//  ToDoViewModel.swift
//  RealToDo
//
//  Created by Руслан Забиран on 14.04.24.
//

import Foundation

protocol ToDoViewModelProtocol {
    
}

class ListViewModel: ToDoViewModelProtocol {
    
    private let taskRepository: TaskRepositoryProtocol
    
    init(taskRepository: TaskRepositoryProtocol = TaskRepository()) {
        self.taskRepository = taskRepository
    }
    
}
