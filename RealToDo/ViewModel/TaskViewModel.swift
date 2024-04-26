//
//  NewTaskViewModel.swift
//  RealToDo
//
//  Created by Руслан Забиран on 17.04.24.
//

import Foundation

protocol TaskViewModelProtocol {
    var textFieldIsEmpty: Dynamic<Bool> {get set}
    var task: TaskDTO? {get set}
    func setTextFieldState(text: String)
    func goToListVC()
    func saveTaskWith(mainText: String, additionalText: String?)
}

class TaskViewModel: TaskViewModelProtocol {
    
    var task: TaskDTO?
    var textFieldIsEmpty: Dynamic<Bool> = Dynamic(false)
    
    private var appCoordinator: AppCoordinator
    private let taskRepository: TaskRepositoryProtocol
    
    init(appCoordinator: AppCoordinator, taskRepository: TaskRepositoryProtocol) {
        self.appCoordinator = appCoordinator
        self.taskRepository = taskRepository
    }
    
    func setTextFieldState(text: String) {
        if text.isEmpty == true {
            textFieldIsEmpty.value = true
        } else {
            textFieldIsEmpty.value = false
        }
    }
    
    func goToListVC() {
        appCoordinator.popViewController()
    }
    
    func saveTaskWith(mainText: String, additionalText: String?) {
        if task != nil {
            task?.mainText = mainText
            task?.additionalText = additionalText
            taskRepository.saveTask(task ?? TaskDTO(mainText: mainText, additionalText: additionalText))
        } else {
            let taskDTO = TaskDTO(mainText: mainText, additionalText: additionalText)
            taskRepository.saveTask(taskDTO)
        }
        
    }
}
