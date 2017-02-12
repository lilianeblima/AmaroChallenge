//
//  RealmController.swift
//  AmaroChallenge
//
//  Created by Liliane Bezerra Lima on 12/02/17.
//  Copyright © 2017 Liliane Bezerra Lima. All rights reserved.
//

import UIKit
import RealmSwift

class RealmController {
    func saveRealm(product:Product, sizeSelect:String)->Bool {
        let prod = Product()
        prod.name           = product.name
        prod.id             = product.style
        prod.image          = product.image
        prod.actualPrice    = product.actualPrice
        prod.sizeSelect     = sizeSelect
        prod.sizeSelect     = sizeSelect
        prod.amount         = 1
        prod.convertPrice()
        product.sizeSelect = sizeSelect
        let exist = self.existProduncListToBuy(product: product)
        if exist {
            return false
        } else {
            let p = ProductRealm().convertToProductRealm(product: prod)
            p.saveRealm()
            return true
        }
        
        
    }
    
    func getAllProducts()->[Product] {
        let prods = getProducts()
        let products = formatterData(productsRealm: prods)
        return products
    }
    
    func getProducts() ->Results<ProductRealm> {
        do {
            let realm = try Realm()
            let products = realm.objects(ProductRealm.self)
            return products
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    
    func formatterData(productsRealm:Results<ProductRealm>)->[Product] {
        var products = [Product]()
        for prod in productsRealm {
            let product = Product()
            product.id                 = prod["id"]                  as? String  ?? ""
            product.name               = prod["name"]                as? String  ?? ""
            product.sizeSelect         = prod["sizeSelect"]          as? String  ?? ""
            product.image              = prod["image"]               as? String  ?? ""
            product.currentPrice       = prod["currentPrice"]        as? Double  ?? 0.0
            product.finalPrice         = prod["finalPrice"]          as? Double  ?? 0.0
            product.amount             = prod["amount"]              as? Int     ?? 1
  
            products.append(product)
        }
     return products
    }
    
    func removeProduct(product:Product) {
        do {
            let realm = try Realm()
            let products = realm.objects(ProductRealm.self)
            for prod in products {
                let id = prod["id"] as? String ?? ""
                if id == product.id {
                    try! realm.write {
                        realm.delete(prod)
                    }
                }
            }
            
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func updateData(product:Product) {
        do {
            let realm = try Realm()
            let products = realm.objects(ProductRealm.self)
            for prod in products {
                let id = prod["id"] as? String ?? ""
                if id == product.id {
                    try! realm.write {
                        prod.setValue(product.amount, forKeyPath: "amount")
                        prod.setValue(product.finalPrice, forKey: "finalPrice")
                    }
                }
            }
            
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

    func existProduncListToBuy(product:Product)->Bool {
        let productsRealms = self.getProducts()
        for prod in productsRealms {
            let id = prod["id"] as? String ?? ""
            if id == product.style {
                let selectSize = prod["sizeSelect"] as? String ?? ""
                if selectSize == product.sizeSelect {
                    return true
                }
            }
        }
        return false
    }
}
