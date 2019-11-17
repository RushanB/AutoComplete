//
//  Prediction.swift
//  AutoComplete
//
//  Created by RB on 2019-11-15.
//  Copyright © 2019 RB. All rights reserved.
//

import Foundation

struct Prediction: Codable {
    let predictionDescription, id: String
    let matchedSubstrings: [MatchedSubstring]
    let placeID, reference: String
    let structuredFormatting: StructuredFormatting
    let terms: [Term]
    let types: [TypeElement]
    
    enum CodingKeys: String, CodingKey {
        case predictionDescription = "description"
        case id
        case matchedSubstrings = "matched_substrings"
        case placeID = "place_id"
        case reference
        case structuredFormatting = "structured_formatting"
        case terms, types
    }
}

// MARK: - MatchedSubstring

struct MatchedSubstring: Codable {
    let length, offset: Int
}

// MARK: - StructuredFormatting

struct StructuredFormatting: Codable {
    let mainText: String
    let mainTextMatchedSubstrings: [MatchedSubstring]
    let secondaryText: String
    
    enum CodingKeys: String, CodingKey {
        case mainText = "main_text"
        case mainTextMatchedSubstrings = "main_text_matched_substrings"
        case secondaryText = "secondary_text"
    }
}

// MARK: - Term

struct Term: Codable {
    let offset: Int
    let value: String
}

enum TypeElement: String, Codable {
    case geocode = "geocode"
    case route = "route"
    case streetAddress = "street_address"
}
