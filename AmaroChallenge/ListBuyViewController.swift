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
    var total    = 0.0
    
    @IBOutlet var labelAmountItem: UILabel!
    @IBOutlet var labelFinalPrice: UILabel!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0..<5 {
            var prod = Product()
            prod.name = "Oi"
            prod.actualPrice = "R$ 100,50"
            prod.sizeSelect = "P"
            prod.image = URL(string: "https://d2odcms9up7saa.cloudfront.net/appdata/images/products/20002575_027_catalog_1.jpg?1459537946")
            prod.convertPrice()
            products.append(prod)
        }
        tableView.reloadData()
        self.calculeTotal()
        self.calculeAmountItem()
    }
    
    func calculeAmountItem() {
        if products.count == 0 {
            labelAmountItem.text = "Você não possuí produtos no carrinho"
        } else if products.count == 1 {
            labelAmountItem.text = "Você possui 1 produto no carrinho"
        } else {
            labelAmountItem.text = products.count.description + " produtos no carrinho"
        }
        
    }
    
    func calculeTotal() {
        total = 0.0
        for product in products {
            total = total + product.finalPrice!
        }
        labelFinalPrice.text = "R$ " + total.description
    }

    func selectAmount(index:Int) {
        let action = UIAlertController(title: "Selecione a quantidade", message: "", preferredStyle: .actionSheet)
        
        for amount in 1..<11 {
            let ActionButton = UIAlertAction(title: amount.description, style: .default, handler: { (action) in
                self.products[index].amount = amount
                self.products[index].finalPrice = Double(amount) * self.products[index].currentPrice!
                let indexPath = IndexPath(row: index, section: 0)
                self.calculeTotal()
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            })
            action.addAction(ActionButton)
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        action.addAction(cancel)
            
        self.present(action, animated: true, completion: nil)
    }
    
    
    
    
    func buttonSelectAmount(button:UIButton) {
        self.selectAmount(index: button.tag)
    }
    
    func buttonRemove(button:UIButton) {
        self.products.remove(at: button.tag)
        self.tableView.reloadData()
        self.calculeTotal()
        self.calculeAmountItem()
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
            cell.buttonAmount.tag = indexPath.row
            cell.buttonAmount.addTarget(self, action: #selector(ListBuyViewController.buttonSelectAmount(button:)), for: .touchDown)
            cell.buttonRemoveList.tag = indexPath.row
            cell.buttonRemoveList.addTarget(self, action: #selector(ListBuyViewController.buttonRemove(button:)), for: .touchDown)
            return cell
        }
        return UITableViewCell()
    }
}

