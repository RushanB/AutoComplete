//
//  AutoComplete.swift
//  AutoComplete
//
//  Created by RB on 2019-11-17.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

struct AutoComplete: Codable {
    let predictions: [Prediction]
    let status: String
}

extension AutoComplete: Equatable {
    static func == (lhs: AutoComplete, rhs: AutoComplete) -> Bool {
        return lhs.status == rhs.status && lhs.predictions.count == rhs.predictions.count
    }
}
