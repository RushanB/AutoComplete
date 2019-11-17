//
//  TextFieldView.swift
//  AutoComplete
//
//  Created by RB on 2019-11-17.
//  Copyright © 2019 RB. All rights reserved.
//

import UIKit

class TextFieldView: UIView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "What's your address?"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor.brandTextColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textfield: UITextField = {
        let textfield = UITextField()
        textfield.tintColor = UIColor.brandColor
        textfield.placeholder = "e.g. 123 Main Street"
        textfield.font = UIFont.preferredFont(forTextStyle: .title3)
        textfield.borderStyle = .none
        textfield.delegate = self
        textfield.textAlignment = .center
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    var textDidChangeAction: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        addSubview(textfield)
        
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
            
            textfield.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 25),
            textfield.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            textfield.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 100),
            textfield.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -100),
            textfield.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func sizeToFit() {
        bounds = CGRect(origin: .zero, size: intrinsicContentSize)
    }
}


extension TextFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, text.count > 3 else { return true }
        textDidChangeAction?(text)
        return true
    }
}
