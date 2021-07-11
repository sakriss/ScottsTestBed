//
//  Data.swift
//  ScottsTestBed
//
//  Created by Scott Kriss on 7/8/21.
//

import Foundation

class Data: Codable
{
    let breed: String
    let country: String
    let origin: String
    let coat: String
    let pattern: String
    
    private enum CodingKeys: String, CodingKey {
        case breed = "breed"
        case country = "country"
        case origin = "origin"
        case coat = "coat"
        case pattern = "pattern"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        breed = try values.decode(String.self, forKey: .breed)
        country = try values.decode(String.self, forKey: .country)
        origin = try values.decode(String.self, forKey: .origin)
        coat = try values.decode(String.self, forKey: .coat)
        pattern = try values.decode(String.self, forKey: .pattern)
    }
}
