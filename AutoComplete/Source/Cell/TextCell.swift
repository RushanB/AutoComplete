//
//  TextCell.swift
//  AutoComplete
//
//  Created by RB on 2019-11-17.
//  Copyright © 2019 RB. All rights reserved.
//

import UIKit
class TextCell: UICollectionViewCell, ViewModelBindable {
    
    // MARK: - View model
    
    var viewModel: CellBindable?
    
    func setup(with viewModel: CellBindable) {
        self.viewModel = viewModel
        guard let vm = viewModel as? TextViewModel else { return }
        
        titleLabel.text = vm.text
        if let alignment = vm.alignment {
            titleLabel.textAlignment = alignment
        }
        
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        titleLabel.textAlignment = .left
    }
    
    // MARK: -
    
    private func setup() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.textColor = UIColor.brandTextColor
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}
