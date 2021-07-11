//
//  Links.swift
//  ScottsTestBed
//
//  Created by Scott Kriss on 7/8/21.
//

import Foundation

class Links: Codable
{
    var url: String?
    var label: String
    var active: Bool
    
    private enum CodingKeys: String, CodingKey {
        case url = "url"
        case label = "label"
        case active = "active"
    }
    
    enum urlType {
        
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        label = try values.decode(String.self, forKey: .label)
        active = try values.decode(Bool.self, forKey: .active)
    }
}
