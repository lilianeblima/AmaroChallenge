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
    @IBOutlet var buttonAmount: UIButton!
    
    // MARK: - Variables
    var product: Product?
    
    // MARK: - Function
    func fillList() {
        if let prod = product {
            labelName.text  = prod.name
            labelPrice.text = "R$ " + (prod.finalPrice?.description)!
            labelSize.text  = "Tamanho: " + (prod.sizeSelect?.description)!
            buttonAmount.setTitle("Quantidade: " + (prod.amount?.description)!, for: .normal)
            
            if let url =  URL(string: prod.image!) {
                imageProduct.af_setImage(withURL: url)
            } else {
                imageProduct.image = UIImage(named: "noPicture")
            }
        }
    }
    
    // MARK: - TableView
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
