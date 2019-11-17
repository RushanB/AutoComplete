//
//  HomeCoordinator.swift
//  AutoComplete
//
//  Created by RB on 2019-11-15.
//  Copyright © 2019 RB. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private let dispatchGroup = DispatchGroup()
    private var searchedPredictions: [Prediction] = []
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: NavigationController
    
    // MARK: - Controllers
    
    private lazy var homeViewController: HomeViewController = {
        let vc = HomeViewController()
        vc.coordinator = self
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        return vc
    }()
    
    private lazy var searchViewController: SearchViewController = {
        let vc = SearchViewController()
        vc.coordinator = self
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        return vc
    }()
    
    // MARK: - Lifecycle
    
    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        searchedPredictions.removeAll()
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    // MARK: - Helper
    
    private func getSearchResults(with keyword: String) {
        let autoCompleteAPI = AutoCompleteAPI(configuration: .default)
        dispatchGroup.enter()
        
        autoCompleteAPI.request(from: .searchPlace(input: keyword)) { result in
            switch result {
            case .success(let response):
                self.searchedPredictions = response.predictions
                self.dispatchGroup.leave()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.searchedPredictions.removeAll()
                self.dispatchGroup.leave()
            }
        }
    }
}

// MARK: - Delegates

extension HomeCoordinator: HomeDelegate {
    func searchButtonTapped() {
        navigationController.pushViewController(searchViewController, animated: true)
    }
}

extension HomeCoordinator: SearchDelegate {
    func didRequestSearch(with keyword: String) {
        getSearchResults(with: keyword)
         dispatchGroup.notify(queue: .main) {
            self.searchViewController.predictions = self.searchedPredictions
         }
    }
}
