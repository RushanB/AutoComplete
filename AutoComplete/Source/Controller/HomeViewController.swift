//
//  HomeViewController.swift
//  AutoComplete
//
//  Created by RB on 2019-11-15.
//  Copyright © 2019 RB. All rights reserved.
//

import UIKit

protocol HomeDelegate: class {
    func searchButtonTapped()
}

class HomeViewController: ViewController {
    
    // MARK: - Properties
    
    private let titleView = TitleView()
    private let welcomeView = WelcomeView()
    
    weak var coordinator: HomeCoordinator?
    weak var delegate: HomeDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: - Helper
    
    private func setup() {
        view.backgroundColor = UIColor.brandBackgroundColor
        
        welcomeView.buttonAction = {
            self.delegate?.searchButtonTapped()
        }
        
        view.addSubview(titleView)
        view.addSubview(welcomeView)
        
        NSLayoutConstraint.activate([
            titleView.centerYAnchor.constraint(equalTo: guide.centerYAnchor, constant: -150),
            titleView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            
            welcomeView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            welcomeView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            welcomeView.leftAnchor.constraint(equalTo: guide.leftAnchor),
            welcomeView.rightAnchor.constraint(equalTo: guide.rightAnchor)
        ])
    }
}
