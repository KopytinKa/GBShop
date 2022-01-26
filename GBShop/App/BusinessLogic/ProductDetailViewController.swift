//
//  ProductDetailViewController.swift
//  GBShop
//
//  Created by Кирилл Копытин on 25.01.2022.
//

import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private let requestFactory = RequestFactory()
    
    private var product: ProductModel?
    var productId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchData()
    }
    
    private func fetchData() {
        let product = requestFactory.makeProductRequestFactory()
        product.getDataById(self.productId) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let product):
                if product.result != 0 {
                    self.product = product.product
                    self.viewData()
                } else {
                    self.showError(product.errorMessage ?? "Неизвестная ошибка")
                }
            case .failure(let error):
                self.showError(error.localizedDescription)
            }
        }
    }
    
    private func viewData() {
        self.priceLabel.text = String(self.product?.price ?? 0)
        self.descriptionLabel.text = self.product?.description
        self.nameLabel.text = self.product?.name
    }
    
    @IBAction func pressAddToBasketButton(_ sender: Any) {
        let addToBasket = requestFactory.makeAddToBasketRequestFactory()
        addToBasket.addToBasket(idProduct: self.productId, quantity: 1) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let addBasketResult):
                if addBasketResult.result != 0 {

                } else {
                    self.showError(addBasketResult.errorMessage ?? "Неизвестная ошибка")
                }
            case .failure(let error):
                self.showError(error.localizedDescription)
            }
        }
    }
}
