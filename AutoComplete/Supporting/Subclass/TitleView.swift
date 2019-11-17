//
//  TitleView.swift
//  AutoComplete
//
//  Created by RB on 2019-11-15.
//  Copyright © 2019 RB. All rights reserved.
//

import UIKit

class TitleView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        
        let guide = UILayoutGuide()
        addLayoutGuide(guide)
        
        NSLayoutConstraint.activate([
            guide.leftAnchor.constraint(equalTo: leftAnchor),
            guide.rightAnchor.constraint(equalTo: rightAnchor),
            guide.bottomAnchor.constraint(equalTo: bottomAnchor),
            guide.centerYAnchor.constraint(equalTo: centerYAnchor),
            guide.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: guide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func sizeToFit() {
        bounds = CGRect(origin: .zero, size: intrinsicContentSize)
    }
    
    override var intrinsicContentSize: CGSize {
        guard let logoSize = imageView.image?.size else {
            return .zero
        }
        
        let navButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let maxWidthToKeepCentered = UIScreen.main.bounds.width - ((navButton.width + 16.0) * 2.0)
        
        return CGSize(width: min(maxWidthToKeepCentered, max(logoSize.width, logoSize.width)), height: 44.0)
        
    }
}
