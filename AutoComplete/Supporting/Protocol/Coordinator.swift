//
//  Coordinator.swift
//  AutoComplete
//
//  Created by RB on 2019-11-15.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

// - Protocol to setup the coordinator pattern
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: NavigationController { get set }
    func start()
    func childDidFinish(_ child: Coordinator?)
}

extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                navigationController.popViewController(animated: false)
                break
            }
        }
    }
}
