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

    @IBOutlet var imageProduct: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelPrice: UILabel!
    @IBOutlet var labelSize: UILabel!
    @IBOutlet var labelAmount: UILabel!
    @IBOutlet var buttonRemoveList: UIButton!
    
    var product: Product?
    
    func fillList() {
        if let prod = product {
            labelName.text  = prod.name
            labelPrice.text = prod.actualPrice
            labelSize.text  = prod.sizeSelect
            
            if let url = prod.image {
                imageProduct.af_setImage(withURL: url)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
