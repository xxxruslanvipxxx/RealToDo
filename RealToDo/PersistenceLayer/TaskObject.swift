//
//  PersistenceModel.swift
//  RealToDo
//
//  Created by Руслан Забиран on 14.04.24.
//

import Foundation
import RealmSwift

final class TaskObject: Object {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var mainText: String
    @Persisted var additionalText: String
    @Persisted var date: Date
    @Persisted var isCompleted: Bool
    
    convenience init(id: String,
                     mainText: String,
                     additionalText: String,
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
