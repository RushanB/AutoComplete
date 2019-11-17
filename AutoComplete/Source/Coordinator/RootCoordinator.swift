//
//  RootCoordinator.swift
//  AutoComplete
//
//  Created by RB on 2019-11-15.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

class RootCoordinator: NSObject, Coordinator {
    
    // MARK: - Properties
    
    var childCoordinators = [Coordinator]()
    var navigationController: NavigationController

    // MARK: - Lifecycle
    
    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHome()
    }
    
    // MARK: - Navigation
    
    private func showHome() {
        let child = HomeCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
}
