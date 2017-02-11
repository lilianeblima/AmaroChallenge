//
//  CatalogViewController.swift
//  AmaroChallenge
//
//  Created by Liliane Bezerra Lima on 11/02/17.
//  Copyright © 2017 Liliane Bezerra Lima. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var products = [Product]()
    
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
    
    func alert(title:String, message:String, sizes:[Size]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for size in sizes {
            if size.available == true {
                let action = UIAlertAction(title: size.size, style: .default, handler: { (actionAlert) in
                    print(size.size ?? "erro")
                })
                alertController.addAction(action)
            }
            
        }
        self.present(alertController, animated: true)
    }
    
    func buttonBuy(button: UIButton) {
        self.alert(title: "Selecione o tamanho", message: "", sizes: products[button.tag].sizes!)
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
