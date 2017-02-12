//
//  Product.swift
//  AmaroChallenge
//
//  Created by Liliane Bezerra Lima on 11/02/17.
//  Copyright © 2017 Liliane Bezerra Lima. All rights reserved.
//

import UIKit

struct Product {
    
    var name:   String?  = nil
    var style:  String?  = nil
    
    var codeColor: String?  = nil
    var colorSlug: String?  = nil
    var color:      String?  = nil

    var onSale:             Bool?   = nil
    var regularPrice:       String? = nil
    var actualPrice:        String? = nil
    var discountPercentage: String? = nil
    var installments:       String? = nil
    
    var image:          URL?     = nil
    var sizes:          [Size]?  = nil
    var sizeSelect:     String?  = nil
    
    var amount:         Int?     = 1
    var finalPrice:     Double?  = 0
    var currentPrice:   Double?  = 0
    

    mutating func convertPrice() {
        var convert = actualPrice!.replacingOccurrences(of: "R$ ", with: "")
        convert = convert.replacingOccurrences(of: ",", with: ".")
        finalPrice = Double(convert)
        currentPrice = Double(convert)
    }
}


