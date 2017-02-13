//
//  ProductBuyTableViewCell.swift
//  AmaroChallenge
//
//  Created by Liliane Bezerra Lima on 11/02/17.
//  Copyright © 2017 Liliane Bezerra Lima. All rights reserved.
//

import UIKit
import AlamofireImage

class ProductBuyTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet var imageProduct: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelPrice: UILabel!
    @IBOutlet var labelSize: UILabel!
    @IBOutlet var buttonRemoveList: UIButton!
    @IBOutlet var buttonAdd: UIButton!
    @IBOutlet var buttonRemove: UIButton!
    @IBOutlet var labelAmount: UILabel!
    
    
    // MARK: - Variables
    var product: Product?
    
    // MARK: - Function
    
    func fillList() {
        if let prod = product {
            self.configureButtonsAmount(button: buttonAdd)
            self.configureButtonsAmount(button: buttonRemove)
            labelName.text  = prod.name
            labelPrice.text = prod.finalPrice?.toPrice()
            
            if let sizeSelect = prod.sizeSelect {
                labelSize.text  = "Tamanho: \(sizeSelect)"
            }
            
            if let amount = prod.amount {
                labelAmount.text = "Quantidade: \(amount)"
            }
            
            if let url =  URL(string: prod.image!) {
                imageProduct.af_setImage(withURL: url, placeholderImage: UIImage(named: "noPicture"))
            } else {
                imageProduct.image = UIImage(named: "noPicture")
            }
        }
    }
    
    func configureButtonsAmount(button:UIButton) {
        button.layer.borderWidth = 0.4
        button.layer.borderColor = UIColor.black.cgColor
        button.roundRadius()
    }
    

    // MARK: - TableView
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
