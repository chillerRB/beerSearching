//
//  URL+Helpers.swift
//  BeerSearching
//
//  Created by Chiller on 10/11/2019.
//  Copyright © 2019 Chiller Pruebas. All rights reserved.
//

import UIKit

extension URL {
    //Funciones que permite gestinar las queries de una petición web
    func withQueries(_ queries: [String: String]) -> URL? {
        
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
