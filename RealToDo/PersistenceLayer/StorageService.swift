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
    
    //MARK: Initializer
    
    init(configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration) {
        self.storage = try? Realm(configuration: configuration)
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    //MARK: CRUD
    
    public func saveOrUpdateObject(object: Object) throws {
        guard let storage else { return }
        storage.writeAsync({
            storage.add(object, update: .all)
        })
    }
    
    public func saveOrUpdateAllObjects(objects: [Object]) throws {
        try objects.forEach { try saveOrUpdateObject(object: $0) }
    }
    
    public func delete(for primaryKey: String) throws {
        guard let storage else { return }
        guard let object = storage.object(ofType: TaskObject.self, forPrimaryKey: primaryKey ) else { return }
        try storage.write {
            storage.delete(object)
        }
    }
    
    public func deleteAll() throws {
        guard let storage else { return }
        try storage.write {
            storage.deleteAll()
        }
    }
    
    public func fetch<T: Object>(by type: T.Type) -> [T] {
        guard let storage else { return []}
        let objects = Array(storage.objects(T.self))

        return objects
    }
    
    
    
}
