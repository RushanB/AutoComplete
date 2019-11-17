//
//  Endpoint.swift
//  AutoComplete
//
//  Created by RB on 2019-11-15.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

// - Generic endpoint to setup URL Request
protocol Endpoint {
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    var apiKey: String {
        // TODO: Should store this in keychain
        return "AIzaSyDr3GaFX-eEzmxVYJuJaW80n39HULxfd8g"
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        return components
    }
    
    var request: URLRequest {
        guard let url = urlComponents.url else { fatalError("must have valid URL") }
        return URLRequest(url: url)
    }
}
