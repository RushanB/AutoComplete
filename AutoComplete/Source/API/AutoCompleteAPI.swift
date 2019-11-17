//
//  AutoCompleteAPI.swift
//  AutoComplete
//
//  Created by RB on 2019-11-15.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

/// - https://maps.googleapis.com/maps/api/place/autocomplete/json?input=1332Ho&types=address&key=AIzaSyDU-pbyDpUVyRSLuLIDEBulQXnUIXK1eew
enum AutoCompleteTarget {
    case searchPlace(input: String)
}

extension AutoCompleteTarget: Endpoint {
    var base: String {
        return "https://maps.googleapis.com"
    }
    
    var path: String {
        switch self {
        case .searchPlace(_): return "/maps/api/place/autocomplete/json"
        }
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        switch self {
        case .searchPlace(let input):
            let input = URLQueryItem(name: "input", value: "\(input)")
            let types = URLQueryItem(name: "types", value: "address")
            let key = URLQueryItem(name: "key", value: "\(apiKey)")
            components.queryItems = [input, types, key]
        }
        return components
    }
    
    var request: URLRequest {
        guard let url = urlComponents.url else { fatalError("must have valid URL") }
        return URLRequest(url: url)
    }
}

class AutoCompleteAPI: API {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    // in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func request(from target: AutoCompleteTarget, completion: @escaping (Result<AutoComplete, APIError>) -> Void) {
        fetch(with: target.request , decode: { json -> AutoComplete? in
            guard let response = json as? AutoComplete else { return  nil }
            return response
        }, completion: completion)
    }
}
