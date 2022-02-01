//
//  CategoryTableViewCell.swift
//  Doyduk
//
//  Created by Firat on 1.02.2022.
//

import UIKit
import Kingfisher

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryDescriptionLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configure(with category: Category) {
        
        self.categoryNameLabel.text = category.name
        self.categoryDescriptionLabel.text = category.prefix
        self.categoryImage.kf.setImage(with: category.imageUrl)
        
    }
    
}
