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
    
    var textfieldText: String? {
        didSet {
            textfield.text = self.textfieldText
        }
    }
    
    weak var searchDelegate: SearchDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addToolBar(to: textfield)
        
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
            textfield.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 50),
            textfield.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -50),
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
    
    private func addToolBar(to textfield: UITextField)  {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.tintColor = UIColor.brandColor
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let nextItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextTapped))
        toolbar.items = [flexSpace, nextItem]
        toolbar.sizeToFit()
        textfield.inputAccessoryView = toolbar
    }
    
    @objc private func nextTapped () {
        searchDelegate?.nextButtonTapped()
    }
}


extension TextFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, text.count > 3 else { return true }
        searchDelegate?.didRequestSearch(with: text)
        return true
    }
}
