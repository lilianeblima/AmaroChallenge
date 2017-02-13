//
//  CatalogViewController.swift
//  AmaroChallenge
//
//  Created by Liliane Bezerra Lima on 11/02/17.
//  Copyright © 2017 Liliane Bezerra Lima. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Variables
    var products = [Product]()
    var productsFilter = [Product]()
    var filter = false
    var badges = 0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetData().getAllproducts { (mProducts) in
            guard let prod = mProducts else {
                return
            }
            products = prod
            self.collectionView.reloadData()
           
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateBadge()
    }
    
    func updateBadge() {
        let prodsRealm = RealmController().getProducts()
        var total = 0
        for prod in prodsRealm {
            guard let amount  = prod["amount"] as? Int else {
                return
            }
            total = total + amount
        }
        
        self.settingsButtonBarRight(badge: total)
    }

    func settingsButtonBarRight(badge:Int) {
        let buttonRight = UIButton(type: .custom)
        buttonRight.frame = CGRect(x: 0, y: 0, width: 35 , height: 35)
        buttonRight.setImage(#imageLiteral(resourceName: "Cart_Icon"), for: .normal)
        
        if badge != 0 {
            let labelBadge = UILabel()
            labelBadge.text = "\(badge)"
            labelBadge.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            labelBadge.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            labelBadge.font = .systemFont(ofSize: 12)
            labelBadge.layer.masksToBounds = true
            labelBadge.layer.frame = CGRect(x: 20, y: 0, width: 18, height: 18)
            labelBadge.roundRadius()
            labelBadge.textAlignment = .center
            buttonRight.addSubview(labelBadge)
        }
        buttonRight.addTarget(self, action: #selector(CatalogViewController.buttonListToBuy(button:)), for: .touchDown)
        let barButtonItem = UIBarButtonItem(customView: buttonRight)
        self.navigationItem.setRightBarButton(barButtonItem, animated: true)
    }

    // MARK: - Buttons
    func buttonBuy(button: UIButton) {
        if products[button.tag].sizes?.count == 1 {
            guard let sizeSelect = products[button.tag].sizes?.first?.size else {
                return
            }
            self.saveRealm(index: button.tag, sizeSelect: sizeSelect)
        } else {
            self.alertSize(title: "Selecione o tamanho", message: "", sizes: products[button.tag].sizes!, index: button.tag)
        }
        
    }
    func buttonListToBuy(button: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let listView = mainStoryboard.instantiateViewController(withIdentifier: "listView")
        self.navigationController?.pushViewController(listView, animated: true)
    }
    
    // MARK: - SegmentedControl
    @IBAction func changedSegmentedControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            products = productsFilter
        } else if sender.selectedSegmentIndex == 1 {
            productsFilter = products
            var prods = [Product]()
            
            for prod in products {
                if prod.onSale! {
                    prods.append(prod)
                }
            }
            products = prods
        }
        self.collectionView.reloadData()
    }
    
    // MARK: - Alert Size
    func alertSize(title:String, message:String, sizes:[Size], index:Int) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for size in sizes {
            if size.available == true {
                let action = UIAlertAction(title: size.size, style: .default, handler: { (actionAlert) in
                    guard let sizeSelect = size.size else {
                        return
                    }
                    self.saveRealm(index: index, sizeSelect: sizeSelect)
                })
                alertController.addAction(action)
            }
            
        }
        self.present(alertController, animated: true)
    }
    
    func saveRealm(index:Int, sizeSelect:String) {
        RealmController().saveRealm(product: self.products[index], sizeSelect: sizeSelect)
        self.updateBadge()
    }
}


// MARK: - Collection View
extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCard", for: indexPath) as? CardCollectionViewCell {
            cell.product = products[indexPath.row]
            cell.fillCell()
            cell.buttonAddToBuy.tag = indexPath.row
            cell.buttonAddToBuy.addTarget(self, action: #selector(CatalogViewController.buttonBuy(button:)), for: .touchDown)
            
            return cell
        }
        return UICollectionViewCell()
    }
}
