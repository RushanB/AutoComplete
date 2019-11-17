//
//  PredictionCell.swift
//  AutoComplete
//
//  Created by RB on 2019-11-17.
//  Copyright © 2019 RB. All rights reserved.
//

import UIKit

class PredictionCell: UICollectionViewCell, ViewModelBindable {
    
    // MARK: - View model
    
    var viewModel: CellBindable?
    
    func setup(with viewModel: CellBindable) {
        self.viewModel = viewModel
        guard let vm = viewModel as? PredictionViewModel else { return }
        
        let tapAction = UITapGestureRecognizer(target: vm, action: #selector(vm.didSelect(sender:)))
        contentView.addGestureRecognizer(tapAction)
        
        addressLabel.text = vm.addressText
        locationLabel.text = vm.locationText
    }
    // MARK: - Properties
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        addressLabel.text = nil
        locationLabel.text = nil
    }
    
    // MARK: -
    
    private func setup() {
        setupLabel(addressLabel, font: UIFont.preferredFont(forTextStyle: .body), textColor: .black)
        setupLabel(locationLabel)
    }
    
    private func setupLabel(_ label: UILabel, font: UIFont = UIFont.preferredFont(forTextStyle: .subheadline), alignment: NSTextAlignment = .left, textColor: UIColor =  UIColor.brandTextColor) {
        label.font = font
        label.textColor = textColor
        label.numberOfLines = 0
        label.textAlignment = alignment
        label.lineBreakMode = .byWordWrapping
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
