//
//  SearchViewController.swift
//  AutoComplete
//
//  Created by RB on 2019-11-15.
//  Copyright © 2019 RB. All rights reserved.
//

import UIKit

protocol SearchDelegate: class {
    func didRequestSearch(with keyword: String)
    func didSelectPrediction(_ prediction: Prediction)
    func nextButtonTapped()
}

class SearchViewController: ViewController {
    
    // MARK: - Properties
    
    var predictions: [Prediction] = [] {
        didSet {
            guard self.predictions.count > 0 else { return }
            reload()
        }
    }
    
    var selectedPrediction: Prediction? {
        didSet {
            let address = self.selectedPrediction?.predictionDescription
            self.textfieldView.textfieldText = address
            self.predictions.removeAll()
            reload()
        }
    }
    
    private var textfieldView = TextFieldView()
    
    private var data: [CellBindable] = []
    private var cellIdentifier = Set<String>()
    
    weak var coordinator: HomeCoordinator?
    weak var delegate: SearchDelegate?
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textfieldView.textfieldText = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Actions
    
    @objc func reload() {
        data = getData()
        collectionView.reloadData()
    }
    
    // MARK: - Helper
    
    private func setup() {
        view.backgroundColor = UIColor.brandBackgroundColor
        collectionView.backgroundColor = UIColor.brandBackgroundColor
        collectionView.dataSource = self
        textfieldView.searchDelegate = self.delegate
        
        view.addSubview(textfieldView)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            textfieldView.topAnchor.constraint(equalTo: guide.topAnchor),
            textfieldView.leftAnchor.constraint(equalTo: guide.leftAnchor),
            textfieldView.rightAnchor.constraint(equalTo: guide.rightAnchor),
            
            collectionView.topAnchor.constraint(equalTo: textfieldView.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: guide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: guide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
        
        reload()
    }
    
    private func getData() -> [CellBindable] {
        var data: [CellBindable] = []
        
        for prediction in predictions {
            let predictionVM = PredictionViewModel(prediction: prediction, delegate: delegate)
            data.append(predictionVM)
        }
        
        return data
    }
        
    func registerNib(on collectionView: UICollectionView, with viewModel: CellBindable) {
        let id = viewModel.reuseIdentifier!
        if !cellIdentifier.contains(id) {
            collectionView.register(UINib(nibName: id, bundle: nil), forCellWithReuseIdentifier: id)
            cellIdentifier.insert(id)
        }
    }
}

// MARK: - DataSource

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = data[indexPath.item]
        registerNib(on: collectionView, with: viewModel)
        let id = viewModel.reuseIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id!, for: indexPath) as! ViewModelBindable & UICollectionViewCell
        cell.setup(with: viewModel)
        return cell
    }
}
