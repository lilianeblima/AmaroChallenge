//
//  ListBuyViewController.swift
//  AmaroChallenge
//
//  Created by Liliane Bezerra Lima on 11/02/17.
//  Copyright © 2017 Liliane Bezerra Lima. All rights reserved.
//

import UIKit

class ListBuyViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var labelAmountItem: UILabel!
    @IBOutlet var labelFinalPrice: UILabel!
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Variables
    var products = [Product]()
    var total    = 0.0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products = RealmController().getAllProducts()
        tableView.reloadData()
        self.calculeTotal()
        self.calculeAmountItem()
    }

    // MARK: - Buttons
    func buttonAddItem(button:UIButton) {
        self.amount(isAdd: true, index: button.tag)
    }
    
    func buttonRemoveItem(button:UIButton) {
        self.amount(isAdd: false, index: button.tag)
    }
    
    func buttonRemove(button:UIButton) {
        RealmController().removeProduct(product: products[button.tag])
        self.products.remove(at: button.tag)
        self.tableView.reloadData()
        self.calculeTotal()
        self.calculeAmountItem()
    }
    
    // MARK: - Functions Total
    func amount(isAdd:Bool, index:Int) {
        guard var currentAmount = self.products[index].amount else {
            return
        }
        if isAdd {
           currentAmount += 1
        } else {
            if currentAmount > 1 {
                currentAmount -= 1
            }
        }
        
        self.products[index].amount = currentAmount
        
        guard let currentPrice = self.products[index].currentPrice else {
            return
        }
        self.products[index].finalPrice = Double(currentAmount) * currentPrice
        let indexPath = IndexPath(row: index, section: 0)
        self.calculeTotal()
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        RealmController().updateData(product: self.products[index])
        self.calculeAmountItem()
        
    }
    
    func calculeAmountItem() {
        var amount = 0
        for product in products {
            guard let prodAmount = product.amount else {
                return
            }
            amount = amount + prodAmount
        }
        
        if amount == 0 {
            labelAmountItem.text = "Você não possui produtos no carrinho"
        } else if amount == 1 {
            labelAmountItem.text = "Você possui 1 produto no carrinho"
        } else {
            labelAmountItem.text = "Você possui \(amount) produtos no carrinho"
        }
        
    }
    
    func calculeTotal() {
        total = 0.0
        for product in products {
            total = total + product.finalPrice!
        }
        labelFinalPrice.text = total.toPrice()
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
            cell.buttonAdd.tag = indexPath.row
            cell.buttonRemove.tag = indexPath.row
            cell.buttonAdd.addTarget(self, action: #selector(ListBuyViewController.buttonAddItem(button:)), for: .touchDown)
            cell.buttonRemove.addTarget(self, action: #selector(ListBuyViewController.buttonRemoveItem(button:)), for: .touchDown)

            cell.buttonRemoveList.tag = indexPath.row
            cell.buttonRemoveList.addTarget(self, action: #selector(ListBuyViewController.buttonRemove(button:)), for: .touchDown)
            return cell
        }
        return UITableViewCell()
    }
}

