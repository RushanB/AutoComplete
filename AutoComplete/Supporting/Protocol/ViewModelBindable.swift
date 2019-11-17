//
//  ViewModelBindable.swift
//  AutoComplete
//
//  Created by RB on 2019-11-15.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

// - Adopted by cells to bind the viewModel to the cell
protocol ViewModelBindable {
    func setup(with viewModel: CellBindable)
    var viewModel: CellBindable? { get set }
}
