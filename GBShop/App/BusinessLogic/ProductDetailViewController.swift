//
//  ProductDetailViewController.swift
//  GBShop
//
//  Created by Кирилл Копытин on 25.01.2022.
//

import UIKit
import Firebase

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
                    Crashlytics.crashlytics().log("get product data success")
                    self.product = product.product
                    self.viewData()
                } else {
                    let message = product.errorMessage ?? "Неизвестная ошибка"
                    Crashlytics.crashlytics().log(message)
                    self.showError(message)
                }
            case .failure(let error):
                Crashlytics.crashlytics().log(error.localizedDescription)
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
                    Crashlytics.crashlytics().log("add to basket success")
                } else {
                    let message = addBasketResult.errorMessage ?? "Неизвестная ошибка"
                    Crashlytics.crashlytics().log(message)
                    self.showError(message)
                }
            case .failure(let error):
                Crashlytics.crashlytics().log(error.localizedDescription)
                self.showError(error.localizedDescription)
            }
        }
    }
}
