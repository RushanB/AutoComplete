//
//  NavigationController.swift
//  AutoComplete
//
//  Created by RB on 2019-11-15.
//  Copyright © 2019 RB. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    // MARK: - Status Bar
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = UIColor.brandBackgroundColor
        navigationBar.isTranslucent = false
        navigationBar.tintColor = UIColor.brandColor
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.brandColor!,
            .font: UIFont.preferredFont(forTextStyle: .body)
        ]
        do {
            let textAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.brandTextColor,
                .font:  UIFont.preferredFont(forTextStyle: .body)
            ]
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [NavigationController.self]).setTitleTextAttributes(textAttributes, for: .normal)
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [NavigationController.self]).setTitleTextAttributes(textAttributes, for: .highlighted)
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [NavigationController.self]).setTitleTextAttributes(textAttributes, for: .selected)
        }
    }
    
    // MARK: -
    
    override var childForStatusBarHidden: UIViewController? {
        return topViewController
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    // MARK: -
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        visibleViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        super.pushViewController(viewController, animated: animated)
    }
}

extension UIViewController {

    // This is used to layout the navigation bar if the text is really long
    func layoutNavBarTitle() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        for view in navigationBar.subviews {
            for subview in view.subviews {
                guard let titleLabel = subview as? UILabel else { break }
                if titleLabel.text == self.title {
                    titleLabel.numberOfLines = 0
                    titleLabel.lineBreakMode = .byWordWrapping
                    titleLabel.sizeToFit()
                    UIView.animate(withDuration: 0.3) {
                        navigationBar.frame.size.height = 57 + titleLabel.frame.height
                    }
                }
            }
        }
    }
}
