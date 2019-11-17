//
//  TextViewModel.swift
//  AutoComplete
//
//  Created by RB on 2019-11-17.
//  Copyright © 2019 RB. All rights reserved.
//

import UIKit

class TextViewModel {
    let text: String
    let attributedText: NSAttributedString?
    
    let alignment: NSTextAlignment?
    
    init(text: String, attributedText: NSAttributedString? = nil, textAlignment: NSTextAlignment? = nil) {
        self.text = text
        self.attributedText = attributedText
        self.alignment = textAlignment
    }
}

extension TextViewModel: CellBindable {
    var reuseIdentifier: String? {
        return "TextCell"
    }
    
    var nibNameOrNil: String? {
        return reuseIdentifier
    }
    
    var cellType: UICollectionViewCell.Type? {
        return nil
    }
}

