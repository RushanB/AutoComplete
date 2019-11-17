//
//  ViewController.swift
//  AutoComplete
//
//  Created by RB on 2019-11-15.
//  Copyright © 2019 RB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    internal let guide = UILayoutGuide()
    
    internal lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: self.view.frame.width, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        view.addLayoutGuide(guide)
        
        NSLayoutConstraint.activate([
            guide.topAnchor.constraint(equalTo: view.topAnchor),
            guide.leftAnchor.constraint(equalTo: view.leftAnchor),
            guide.rightAnchor.constraint(equalTo: view.rightAnchor),
            guide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            guide.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            guide.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    // MARK: -
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
