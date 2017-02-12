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
            self.settingsButtonBarRight(badge: 0)
        }
    }

    func settingsButtonBarRight(badge:Int) {
        let buttonRight = UIButton(type: .custom)
        buttonRight.frame = CGRect(x: 0, y: 0, width: 40 , height: 40)
        buttonRight.setImage(UIImage(named: "car"), for: .normal)
        
        if badge != 0 {
            let labelBadge = UILabel()
            labelBadge.text = " " + badge.description
            labelBadge.backgroundColor = UIColor.red
            labelBadge.textColor = UIColor.white
            labelBadge.layer.masksToBounds = true
            labelBadge.layer.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            labelBadge.layer.cornerRadius = 10
            buttonRight.addSubview(labelBadge)
        }
        buttonRight.addTarget(self, action: #selector(CatalogViewController.buttonListToBuy(button:)), for: .touchDown)
        let barButtonItem = UIBarButtonItem(customView: buttonRight)
        self.navigationItem.setRightBarButton(barButtonItem, animated: true)
    }

    // MARK: - Buttons
    func buttonBuy(button: UIButton) {
        self.alert(title: "Selecione o tamanho", message: "", sizes: products[button.tag].sizes!)
    }
    func buttonListToBuy(button: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let listView = mainStoryboard.instantiateViewController(withIdentifier: "listView")
        self.navigationController?.pushViewController(listView, animated: true)
    }
    
    @IBAction func buttonFilter(_ sender: UIBarButtonItem) {
        if filter == false {
            filter = true
            productsFilter = products
            var prods = [Product]()
            
            for prod in products {
                if prod.onSale! {
                    prods.append(prod)
                }
            }
            products = prods
        } else {
            filter = false
            products = productsFilter
        }
        self.collectionView.reloadData()
    }
    
    // MARK: - Alert Size
    func alert(title:String, message:String, sizes:[Size]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for size in sizes {
            if size.available == true {
                let action = UIAlertAction(title: size.size, style: .default, handler: { (actionAlert) in
                    print(size.size ?? "erro")
                    self.badges += 1
                    self.settingsButtonBarRight(badge: self.badges)
                })
                alertController.addAction(action)
            }
            
        }
        self.present(alertController, animated: true)
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
