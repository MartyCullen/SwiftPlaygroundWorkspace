//
//  Job.swift
//  Validic_test
//
//  Created by Marty Cullen on 1/8/18.
//  Copyright © 2018 Marty Cullen. All rights reserved.
//

import Foundation

struct Job {
    let id: String
    let description: String
    let location: String
    let url: URL
    
    init(id: String, description: String, location: String, url: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.url = url
    }
}

extension Job: Decodable {
    enum MyStructKeys: String, CodingKey {
        case id = "id"
        case description = "description"
        case location = "location"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MyStructKeys.self)

        let id: String = try container.decode(String.self, forKey: .id)
        let description: String = try container.decode(String.self, forKey: .description)
        let location: String = try container.decode(String.self, forKey: .location)
        let url: URL = try container.decode(URL.self, forKey: .url)
        
        self.init(id: id, description: description, location: location, url: url)
    }
}

