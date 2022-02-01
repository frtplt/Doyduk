//
//  CategoryViewController.swift
//  Doyduk
//
//  Created by Firat on 2.02.2022.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var favoriteCategoryLabel: UILabel!
    @IBOutlet weak var favoriteCategoryImageView: UIImageView!
    @IBOutlet weak var favoriteProductTitleLabel: UILabel!
    @IBOutlet weak var categoryTableView: UITableView!
    
    var categories: [Category] = [] {
        didSet{
            DispatchQueue.main.async {
                self.categoryTableView.reloadData()
            }
        }
    }
    
    var categoriesTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        setFavoriteItems()
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.title = categoriesTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCategories()
        setFavoriteItems()
    }
    
    
    func configureTableView() {
    
        let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        categoryTableView.register(nib, forCellReuseIdentifier: "CategoryTableViewCell")
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
    }

    // MARK: - Tableview Methods

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return categories.count
    }
    
    func getCategories() {
        
        let service = WebService()
        
        service.getCategory { categoryResponse in
            self.categories = categoryResponse.result
        }
    }
    
    func setFavoriteItems() {
        
        DispatchQueue.main.async {
            
            let favoriteProduct: FavoriteProduct
            
            if let data = UserDefaults.standard.data(forKey: "favoriteProduct") {
                
                let username = UserDefaults.standard.string(forKey: "name")!
                self.favoriteProductTitleLabel.text = "\(username) kullanıcısının favori ürünü"
                let decoder = JSONDecoder()
                favoriteProduct = try! decoder.decode(FavoriteProduct.self, from: data)
            }
            else {
                self.favoriteProductTitleLabel.text = "Bugünün favori kategorisi"
                let randomIndex = Int.random(in: 0 ..< self.categories.count)
                favoriteProduct = FavoriteProduct(name: self.categories[randomIndex].name, imageUrl: self.categories[randomIndex].imageUrl)
            }
            
            self.favoriteCategoryLabel.text = favoriteProduct.name
            self.favoriteCategoryImageView.kf.setImage(with: favoriteProduct.imageUrl)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        
        let category = categories[indexPath.row]
        
        cell.configure(with: category)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let products = ProductTableViewController()
        
        products.categoryName = categories[indexPath.row].name
        self.navigationController?.pushViewController(products, animated: true)
        
    }
}
