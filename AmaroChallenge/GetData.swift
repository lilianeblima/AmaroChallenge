//
//  GetData.swift
//  AmaroChallenge
//
//  Created by Liliane Bezerra Lima on 11/02/17.
//  Copyright © 2017 Liliane Bezerra Lima. All rights reserved.
//

import Foundation

class GetData {
    func getAllproducts(completionHandler: (_ products: [Product]?) ->()) {
        self.readData { (jsonResult) in
            guard let json = jsonResult else {
                completionHandler(nil)
                return
            }
            
            guard let results = json as? [String:Any] else {
                completionHandler(nil)
                return
            }
            
            guard let productsJson = results["products"] as? [AnyObject] else {
                completionHandler(nil)
                return
            }
            
            var products = [Product]()
            for productJson in productsJson {
                var product = Product()
                
                product.name               = productJson["name"]                as? String  ?? ""
                product.style              = productJson["style"]               as? String  ?? ""
                product.codeColor          = productJson["code_color"]          as? String  ?? ""
                product.colorSlug          = productJson["color_slug"]          as? String  ?? ""
                product.color              = productJson["color"]               as? String  ?? ""
                product.onSale             = productJson["on_sale"]             as? Bool    ?? nil
                product.regularPrice       = productJson["regular_price"]       as? String  ?? ""
                product.actualPrice        = productJson["actual_price"]        as? String  ?? ""
                product.discountPercentage = productJson["discount_percentage"] as? String  ?? ""
                product.installments       = productJson["installments"]        as? String  ?? ""
                
                let imageURL = productJson["image"] as? String ?? ""
                if let url = URL(string: imageURL) {
                    product.image = url
                }
                
                if let sizesJson = productJson["sizes"] as? [AnyObject] {
                    for sizeJson in sizesJson {
                        var size = Size()
                        size.available  = sizeJson["available"]  as? Bool    ?? nil
                        size.size       = sizeJson["size"]       as? String  ?? ""
                        size.sku        = sizeJson["sku"]        as? String  ?? ""
                        product.sizes?.append(size)
                    }
                }
                
                products.append(product)
                
            }
            completionHandler(products)
            
        }
    }
    
    func readData(completionHandler: (_ json: AnyObject?) ->()) {
        if let path = Bundle.main.path(forResource: "products",ofType:"json") {
            if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                do {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    
                    completionHandler(json)
                } catch {
                    completionHandler(nil)
                }
            } else {
                completionHandler(nil)
            }
        } else {
            completionHandler(nil)
        }
    }
}
