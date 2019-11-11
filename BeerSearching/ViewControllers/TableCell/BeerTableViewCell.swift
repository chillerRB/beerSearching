//
//  BeerTableViewCell.swift
//  BeerSearching
//
//  Created by Chiller on 10/11/2019.
//  Copyright © 2019 Chiller Pruebas. All rights reserved.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageBeer: UIImageView!
    @IBOutlet weak var nameBeerLbl: UILabel!
    @IBOutlet weak var descriptionBeerLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configBerCell(beer: Beer)  {
        
        nameBeerLbl.text = "\(beer.id) : \(beer.name)"
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
