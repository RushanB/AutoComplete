//
//  Decodable.swift
//  AutoComplete
//
//  Created by RB on 2019-11-17.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

// Testing
extension Decodable {
  static func parse(jsonFile: String) -> Self? {
    guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let output = try? JSONDecoder().decode(self, from: data)
        else {
      return nil
    }

    return output
  }
}
