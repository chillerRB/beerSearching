//
//  BeerController.swift
//  BeerSearching
//
//  Created by Chiller on 10/11/2019.
//  Copyright © 2019 Chiller Pruebas. All rights reserved.
//

import UIKit

class BeerController: NSObject {

    static let shared = BeerController()
    /**
     Función que permite obtener beers*/
    func fetchBeers(completion: @escaping ([Beer]?) -> Void) {
        
        let url = URL(string: URLs.baseUrl)!
        
        let task = URLSession.shared.dataTask(with: url) { (data,
            response, error) in
            let decoder = JSONDecoder()
            if let data = data,
                let beers = try? decoder.decode([Beer].self, from: data) {
                completion(beers)
                
            } else {
                print("Either no data was returned, or data was not serialized.")
                completion(nil)
                return
            }
        }
        
        task.resume()
    }
    
    //Función que permite realizar las busqueda con la API proporcionada
    func fetchBeersByString(query: [String: String], completion: @escaping ([Beer]?) -> Void) {
        
        let baseURL = URL(string: URLs.baseUrl + "?")!
        
        guard let url = baseURL.withQueries(query) else {
            completion(nil)
            print("Unable to build URL with supplied queries.")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data,
            response, error) in
            let decoder = JSONDecoder()
            if let data = data,
                let beers = try? decoder.decode([Beer].self, from: data) {
                completion(beers)
                
            } else {
                print("Either no data was returned, or data was not serialized.")
                completion(nil)
                return
            }
        }
        
        task.resume()
    }
    
    //Función que permite obtener la imagen de cada beer
    func fetchImage(url:URL, completion: @escaping (UIImage?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let data = data,
                let image = UIImage(data: data){
                completion(image)
            }else{
                print("No image retrieve")
                completion(nil)
            }
        }
        task.resume()
    }
}
