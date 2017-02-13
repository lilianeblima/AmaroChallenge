//
//  AmaroChallengeTests.swift
//  AmaroChallengeTests
//
//  Created by Liliane Bezerra Lima on 11/02/17.
//  Copyright © 2017 Liliane Bezerra Lima. All rights reserved.
//

import XCTest
@testable import AmaroChallenge
import Foundation
import UIKit

extension UIViewController {
    
    func preload() {
        _ = self.view
    }
    
}

class AmaroChallengeTests: XCTestCase {
    
    var catalogViewController: CatalogViewController!
    var listBuyViewController: ListBuyViewController!
    
    override func setUp() {
        super.setUp()
        catalogViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "catalogView") as! CatalogViewController
        catalogViewController.preload()
        
        listBuyViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listView") as! ListBuyViewController
        listBuyViewController.preload()
    }
    
    // MARK: - CatalogViewController
    
    func testNumberItensCatalogViewController() {
        var products = [Product]()
        for i in 0..<10 {
            let product = Product()
            product.name = "Product " + i.description
            products.append(product)
        }
        catalogViewController.products = products
        catalogViewController.collectionView.reloadData()
        
        XCTAssertEqual(catalogViewController.collectionView.numberOfItems(inSection: 0), 10, "Número de elementos na collectionView deve ser igual a 10")
    }
    
    // MARK: - ListBuyViewController
    
    func testNumberItensListBuyViewController() {
        var products = [Product]()
        for i in 0..<10 {
            let product = Product()
            product.name = "Product " + i.description
            products.append(product)
        }
        listBuyViewController.products = products
        listBuyViewController.tableView.reloadData()
        
        XCTAssertEqual(listBuyViewController.tableView.numberOfRows(inSection: 0), 10, "Número de linhas na tableView deve ser igual a 10")
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
