//
//  PredictionViewModel.swift
//  AutoComplete
//
//  Created by RB on 2019-11-15.
//  Copyright © 2019 RB. All rights reserved.
//

import UIKit

class PredictionViewModel {
    private let prediction: Prediction
    
    init(prediction: Prediction) {
        self.prediction = prediction
    }
    
    var addressText: String {
        return prediction.structuredFormatting.mainText
    }
    
    var locationText: String {
        return prediction.structuredFormatting.secondaryText
    }
}

extension PredictionViewModel: CellBindable {
    var reuseIdentifier: String? {
        return "PredictionCell"
    }
    
    var nibNameOrNil: String? {
        return reuseIdentifier
    }
    
    var cellType: UICollectionViewCell.Type? {
        return nil
    }
}