//
//  Coordinator.swift
//  RealToDo
//
//  Created by Руслан Забиран on 17.04.24.
//

import Foundation
import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
