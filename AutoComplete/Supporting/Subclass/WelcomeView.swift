//
//  WelcomeView.swift
//  AutoComplete
//
//  Created by RB on 2019-11-17.
//  Copyright © 2019 RB. All rights reserved.
//

import UIKit

class WelcomeView: UIView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "welcome to auto complete".capitalized
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textColor = UIColor.brandTextColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.titleEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        button.setTitle("Search Address", for: .normal)
        button.setTitleColor(UIColor.brandBackgroundColor, for: .normal)
        button.backgroundColor = UIColor.brandColor
        button.clipsToBounds = false
        button.layer.cornerRadius = 16
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var buttonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        addSubview(button)
        
        let guide = UILayoutGuide()
        addLayoutGuide(guide)
        
        NSLayoutConstraint.activate([
            guide.leftAnchor.constraint(equalTo: leftAnchor),
            guide.rightAnchor.constraint(equalTo: rightAnchor),
            guide.bottomAnchor.constraint(equalTo: bottomAnchor),
            guide.centerYAnchor.constraint(equalTo: centerYAnchor),
            guide.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            label.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            label.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            label.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 50),
            label.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -50),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 100),
            button.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            button.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 100),
            button.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -100),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func sizeToFit() {
        bounds = CGRect(origin: .zero, size: intrinsicContentSize)
    }
    
    @objc private func buttonTapped() {
        buttonAction?()
    }
}
