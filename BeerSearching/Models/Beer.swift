//
//  Beer.swift
//  BeerSearching
//
//  Created by Chiller on 10/11/2019.
//  Copyright © 2019 Chiller Pruebas. All rights reserved.
//

import Foundation

struct Beer: Codable {
    let id: Int
    let name: String
    //let tagline: String
    //let firstBrewed: Date
    let description: String
    let imageUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        //case tagline
        //case firstBrewed = "first_brewed"
        case description
        case imageUrl = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: CodingKeys.id)
        name = try values.decode(String.self, forKey: CodingKeys.name)
        description = try values.decode(String.self, forKey: CodingKeys.description)
        imageUrl = try? values.decode(URL.self, forKey: CodingKeys.imageUrl)
    }
}
