//
//  TaskDTO.swift
//  RealToDo
//
//  Created by Руслан Забиран on 14.04.24.
//

import Foundation

//MARK: - TaskDTO

struct TaskDTO {
    var id: String
    var mainText: String
    var additionalText: String
    var date: Date
    var isCompleted: Bool
}

//MARK: - TaskDTO init from persistence to dto model

extension TaskDTO {
    init(object: TaskObject) {
        self.id = object.id
        self.mainText = object.mainText
        self.additionalText = object.additionalText
        self.date = object.date
        self.isCompleted = object.isCompleted
    }
}
