//
//  TableViewController.swift
//  Doyduk
//
//  Created by Firat on 1.02.2022.
//

import UIKit

class ProductTableViewController: UITableViewController {
        
    var categoryName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        getProducts()
        navigationItem.title = categoryName
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProducts()
    }
    
    var products: [Product] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    
    }
    
    func configureTableView() {
        
        tableView.rowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ProductTableViewCell")
        
    }
    func getProducts() {
        
        let service = WebService()
        
        service.getProduct { productsResponse in
            self.products = productsResponse.result
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell

        let product = products[indexPath.row]
        cell.configure(with: product)

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let productDetails = ProductDetailsViewController(productId: products[indexPath.row].id)
        self.navigationController?.pushViewController(productDetails, animated: true)
    }

}
