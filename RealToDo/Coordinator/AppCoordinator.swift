//
//  AppCoordinator.swift
//  RealToDo
//
//  Created by Руслан Забиран on 17.04.24.
//

import Foundation
import UIKit
class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
        print("App coord start")
    }
    
    
}
