//
//  ProductRealm.swift
//  AmaroChallenge
//
//  Created by Liliane Bezerra Lima on 12/02/17.
//  Copyright © 2017 Liliane Bezerra Lima. All rights reserved.
//

import UIKit
import RealmSwift

class ProductRealm: Object {
    
    var id:                 String?     = nil
    var name:               String?     = nil
    var image:              String?     = nil
    var sizeSelect:         String?     = nil
    var amount =            RealmOptional<Int>()
    var finalPrice =        RealmOptional<Double>()
    var currentPrice =      RealmOptional<Double>()

    func convertToProductRealm(product:Product)->ProductRealm {
        let productRealm = ProductRealm()
        productRealm.id             = product.id
        productRealm.name           = product.name
        productRealm.image          = product.image
        productRealm.sizeSelect     = product.sizeSelect
        productRealm.amount         = RealmOptional(product.amount)
        productRealm.finalPrice     = RealmOptional(product.finalPrice)
        productRealm.currentPrice   = RealmOptional(product.currentPrice)
        
        return productRealm
    }

    func saveRealm() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}
