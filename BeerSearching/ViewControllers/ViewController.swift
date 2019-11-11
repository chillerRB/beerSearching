//
//  ViewController.swift
//  BeerSearching
//
//  Created by Chiller on 10/11/2019.
//  Copyright © 2019 Chiller Pruebas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageBeer: UIImageView!
    @IBOutlet weak var nameBeerLbl: UILabel!
    @IBOutlet weak var descriptionBeerLbl: UILabel!
    
    var beer: Beer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }


    func updateUI(){
        guard let beer = beer else { return }
        
        nameBeerLbl.text = beer.name
        descriptionBeerLbl.text = beer.description
        if let url = beer.imageUrl {
            BeerController.shared.fetchImage(url: url) { (image) in
                guard let image = image else {return}
                DispatchQueue.main.async {
                    self.imageBeer.image = image
                }
            }
        }
        
    }
}

