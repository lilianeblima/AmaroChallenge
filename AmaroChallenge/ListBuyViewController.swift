//
//  ListBuyViewController.swift
//  AmaroChallenge
//
//  Created by Liliane Bezerra Lima on 11/02/17.
//  Copyright © 2017 Liliane Bezerra Lima. All rights reserved.
//

import UIKit

class ListBuyViewController: UIViewController {

    var products = [Product]()
    
    @IBOutlet var labelAmountItem: UILabel!
    
    @IBOutlet var labelFinalPrice: UILabel!
    
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0..<5 {
            var prod = Product()
            prod.name = "Oi"
            prod.actualPrice = "R$ 100,00"
            prod.sizeSelect = "P"
            prod.image = URL(string: "https://d2odcms9up7saa.cloudfront.net/appdata/images/products/20002575_027_catalog_1.jpg?1459537946")
            products.append(prod)
        }
        tableView.reloadData()
    }

}

// MARK: - Table View
extension ListBuyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cellBuy", for: indexPath) as? ProductBuyTableViewCell {
            cell.product = products[indexPath.row]
            cell.fillList()
            return cell
        }
        return UITableViewCell()
    }
}

