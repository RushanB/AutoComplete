//
//  CellBindable.swift
//  AutoComplete
//
//  Created by RB on 2019-11-15.
//  Copyright © 2019 RB. All rights reserved.
//

import UIKit

// used by ViewModels to bind them to cell types and cell ids
protocol CellBindable: CustomStringConvertible {
    var reuseIdentifier: String? { get }
    var nibNameOrNil: String? { get }
    // only used for non-nib cells, use nibName for nibs
    var cellType: UICollectionViewCell.Type? { get }
}

extension CellBindable {
    var reuseIdentifier: String? {
        let result: String? = nibNameOrNil == nil ? String(describing: cellType) : nibNameOrNil
        return result
    }
    
    var nibNameOrNil: String? {
        let result: String? = cellType == nil ? reuseIdentifier : String(describing: cellType)
        return result
    }
}

extension CellBindable {
    var description: String {
        return """
        reuseIdentifier: \(reuseIdentifier ?? "")
        nibName: \(nibNameOrNil ?? "")
        cellType: \(String(describing: cellType))
        """
    }
}
