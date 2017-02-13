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
    @IBOutlet var buttonAddToBuy: UIButton!
    @IBOutlet var labelDiscount: UILabel!
    
    // MARK: - Variables
    var product: Product?

    // MARK: - Functions
    func borderImage() {
        image.layer.borderWidth = 0.6
        image.layer.borderColor = UIColor.blue.cgColor
        image.layer.cornerRadius = 10
    }
    
    func fillCell() {
        if let prod = product {
            self.borderImage()
            
            labelName.text = prod.name
            
            if prod.onSale == true {
                labelNormalPrice.isHidden = false
                if let regularPrice = prod.regularPrice {
                    labelNormalPrice.text = "De: \(regularPrice)"
                }
                
                labelDiscount.isHidden = false
                labelDiscount.layer.masksToBounds = true
                labelDiscount.layer.cornerRadius = 35
                if let discountPercentage = prod.discountPercentage {
                    labelDiscount.text = "-\(discountPercentage)"
                }
                
            } else {
                labelDiscount.isHidden = true
                labelNormalPrice.isHidden = true
            }
            
            if let actualPrice = prod.actualPrice {
                labelFinalPrice.text = "Por: \(actualPrice)"
            }
            
            
            if let url =  URL(string: prod.image!) {
                image.af_setImage(withURL: url, placeholderImage: UIImage(named: "noPicture"))
            } else {
                image.image = UIImage(named: "noPicture")
            }
            
            self.settingsSizes(prod: prod)
        }
    }
    
    func settingsSizes(prod:Product) {
        if sizeStackView.arrangedSubviews.count != 0 {
            for viewStack in sizeStackView.arrangedSubviews {
                sizeStackView.removeArrangedSubview(viewStack)
                viewStack.removeFromSuperview()
            }
        }
        for size in prod.sizes! {
            if size.available == true {
                let label = UILabel()
                label.text = size.size
                sizeStackView.addArrangedSubview(label)
            }
        }
    }
    
    
    
}
