//
//  ProductDetailsViewController.swift
//  Doyduk
//
//  Created by Firat on 1.02.2022.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    private let productId: Int
    var product: Product?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    init(productId: Int) {
        self.productId = productId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getProductDetails()
        configureImageView()
    }

    func getProductDetails() {
        
        let service = WebService()
        
        service.getProductDetails(id: productId) { productDetailsResponse in
            
            DispatchQueue.main.async {
                
                self.product = productDetailsResponse.result
                
                self.imageView.kf.setImage(with: productDetailsResponse.result.imageUrl)
                self.nameLabel.text = productDetailsResponse.result.name
                self.priceLabel.text = "₺\(productDetailsResponse.result.price)"
                self.descriptionTextView.text = productDetailsResponse.result.description
                
                self.title = productDetailsResponse.result.name
            }
        }
    }
    
    func configureImageView() {
        
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionDoubleTapOnImageView))
        tapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func actionDoubleTapOnImageView() {
        
        if let product = self.product {
            let favoriteProduct = FavoriteProduct(name: product.name, imageUrl: product.imageUrl)
            
            let encoder = JSONEncoder()
            let data = try! encoder.encode(favoriteProduct)
            UserDefaults.standard.set(data, forKey: "favoriteProduct")
            
            let message = "\(favoriteProduct.name) ürününü favori ürünün olarak belirledik :)"
            
            let alert = UIAlertController(title: "Harika!", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
