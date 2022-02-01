//
//  ProductTableViewCell.swift
//  Doyduk
//
//  Created by Firat on 1.02.2022.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with product: Product) {
        productNameLabel.text = product.name
        productDescriptionLabel.text = product.description
        productPriceLabel.text = "₺\(product.price)"
        productImage.kf.setImage(with: product.imageUrl)
    }
    
    
    
}
