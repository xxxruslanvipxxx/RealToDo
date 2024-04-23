//
//  NewTaskViewModel.swift
//  RealToDo
//
//  Created by Руслан Забиран on 17.04.24.
//

import Foundation

protocol TaskViewModelProtocol {
    var textFieldIsEmpty: Dynamic<Bool> {get set}
    func setTextFieldState(text: String)
    func goToListVCWith(mainText: String, additionalText: String?)
}

class TaskViewModel: TaskViewModelProtocol {
    
    var appCoordinator: AppCoordinator
    var textFieldIsEmpty: Dynamic<Bool> = Dynamic(false)
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    func setTextFieldState(text: String) {
        if text.isEmpty == true {
            textFieldIsEmpty.value = true
        } else {
            textFieldIsEmpty.value = false
        }
    }
    
    func goToListVCWith(mainText: String, additionalText: String?) {
        
        appCoordinator.popViewController()
        
        // continue here
    }
}
