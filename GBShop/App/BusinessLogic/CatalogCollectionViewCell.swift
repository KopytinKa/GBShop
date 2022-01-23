//
//  CatalogCollectionViewCell.swift
//  GBShop
//
//  Created by Кирилл Копытин on 23.01.2022.
//

import UIKit

class CatalogCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setup() {
    }
    
    func clearCell() {
        self.nameLabel.text = nil
        self.descriptionLabel.text = nil
        self.priceLabel.text = nil
    }
    
    func configure(product: ProductModel) {
        self.nameLabel.text = product.name
        self.descriptionLabel.text = product.description
        self.priceLabel.text = String(product.price)

    }
    
    override func prepareForReuse() {
        clearCell()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }
}
