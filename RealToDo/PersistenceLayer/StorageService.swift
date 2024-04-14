//
//  StorageService.swift
//  RealToDo
//
//  Created by Руслан Забиран on 14.04.24.
//

import Foundation
import RealmSwift

//MARK: - StorageService
final class StorageService {
    
    private let storage: Realm?
    
    init(configuration: Realm.Configuration = Realm.Configuration(inMemoryIdentifier: "inMemory")) {
        self.storage = try? Realm(configuration: configuration)
    }
    
}
