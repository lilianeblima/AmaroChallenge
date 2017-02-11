//
//  CardCollectionViewCell.swift
//  AmaroChallenge
//
//  Created by Liliane Bezerra Lima on 11/02/17.
//  Copyright © 2017 Liliane Bezerra Lima. All rights reserved.
//

import UIKit
import AlamofireImage

class CardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet var image: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelNormalPrice: UILabel!
    @IBOutlet var labelFinalPrice: UILabel!
    @IBOutlet var sizeStackView: UIStackView!
    
    
    // MARK: - Variables
    var product: Product?
    
    func fillCell() {
        if let prod = product {
            
            labelName.text = prod.name
            
            if prod.onSale == true {
                labelNormalPrice.isHidden = false
                labelNormalPrice.text = prod.regularPrice
            } else {
                labelNormalPrice.isHidden = true
            }
            labelFinalPrice.text = prod.actualPrice
            
            if let url = prod.image {
                image.af_setImage(withURL: url)
            }
            
            self.settingsSizes(prod: prod)
            
        
            
            //sizeStackView.addArrangedSubview(label)
            
        }
        
    }
    
    func settingsSizes(prod:Product) {
        for size in prod.sizes! {
            if size.available == true {
                let label = UILabel()
                label.text = size.size
                sizeStackView.addArrangedSubview(label)
            }
            
        }
    }
    
    
    
}
