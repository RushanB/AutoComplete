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
                /// - uncomment for testing
                 guard let output = AutoComplete.parse(jsonFile: "AutoComplete") else {
                 return
                 }
                 self.searchedPredictions = output.predictions
                //self.searchedPredictions = response.predictions
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
    
    func nextButtonTapped() {
        if searchViewController.selectedPrediction == nil {
            let alert = UIAlertController(title: "Oops", message: "You must have a valid address to continue", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            searchViewController.present(alert, animated: true, completion: nil)
        } else {
            // Show success and pop
            let alert = UIAlertController(title: "Success", message: "Your address has been validated!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
                alert.dismiss(animated: true) {
                    self.searchViewController.selectedPrediction = nil
                    self.navigationController.popViewController(animated: true)
                }
            }
            alert.addAction(okAction)
            searchViewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func didSelectPrediction(_ prediction: Prediction) {
        searchViewController.selectedPrediction = prediction
    }
}
