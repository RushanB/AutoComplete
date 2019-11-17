//
//  NetworkTests.swift
//  AutoCompleteTests
//
//  Created by RB on 2019-11-17.
//  Copyright © 2019 RB. All rights reserved.
//

import XCTest
@testable import AutoComplete

class NetworkTests: XCTestCase {
    
    func testAutoCompleteAPI() {
        guard let output = AutoComplete.parse(jsonFile: "AutoComplete") else {
            return
        }
        let autoCompleteAPI = AutoCompleteAPI(configuration: .default)
        autoCompleteAPI.request(from: .searchPlace(input: "1132 Ho")) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(output, response)
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
}
