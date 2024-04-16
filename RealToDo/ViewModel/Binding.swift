//
//  Binding.swift
//  RealToDo
//
//  Created by Руслан Забиран on 16.04.24.
//

import Foundation

//MARK: - Dynamic

class Dynamic<T> {
    
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
}
