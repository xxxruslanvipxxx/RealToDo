//
//  PersistenceModel.swift
//  RealToDo
//
//  Created by Руслан Забиран on 14.04.24.
//

import Foundation
import RealmSwift

//MARK: - TaskObject

final class TaskObject: Object {
    
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var mainText: String
    @Persisted var additionalText: String?
    @Persisted var date: Date
    @Persisted var isCompleted: Bool
    
    convenience init(id: Int,
                     mainText: String,
                     additionalText: String?,
                     date: Date,
                     isCompleted: Bool) {
        self.init()
        self.id = id
        self.mainText = mainText
        self.additionalText = additionalText
        self.date = date
        self.isCompleted = isCompleted
    }
    
}

//MARK: - TaskObject init from dto model to persistence model

extension TaskObject {
    convenience init(dto: TaskDTO) {
        self.init()
        self.id = dto.id
        self.mainText = dto.mainText
        self.additionalText = dto.additionalText
        self.date = dto.date
        self.isCompleted = dto.isCompleted
    }
}
