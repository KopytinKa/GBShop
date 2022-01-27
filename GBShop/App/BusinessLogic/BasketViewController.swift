//
//  BasketViewController.swift
//  GBShop
//
//  Created by Кирилл Копытин on 26.01.2022.
//

import UIKit
import Firebase

class BasketViewController: UIViewController {
    @IBOutlet weak var basketTableView: UITableView!
    
    private let requestFactory = RequestFactory()
    
    private var products: [ProductModel] = [
        ProductModel(
            id: 1,
            name: "Monitor",
            price: 49000,
            description: "Big monitor"
        ),
        ProductModel(
            id: 2,
            name: "Keyboard",
            price: 1200,
            description: "Cool keyboard"
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.basketTableView.dataSource = self
        self.basketTableView.delegate = self
    }
    
    @IBAction func pressPayButton(_ sender: Any) {
        let payBasket = requestFactory.makePayBasketRequestFactory()
        payBasket.payBasket(idUser: 1) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let payResult):
                if payResult.result != 0 {
                    Crashlytics.crashlytics().log("pay basket success")
                    self.products = []
                    self.basketTableView.reloadData()
                } else {
                    let message = payResult.errorMessage ?? "Неизвестная ошибка"
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

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "BasketCellIdentifier", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = String(product.price)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            let deleteFromBasket = requestFactory.makeDeleteFromBasketRequestFactory()
            deleteFromBasket.deleteFromBasket(idProduct: 1) { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case .success(let deleteResult):
                    if deleteResult.result != 0 {
                        self.products.remove(at: indexPath.row)
                        self.basketTableView.reloadData()
                    } else {
                        self.showError(deleteResult.errorMessage ?? "Неизвестная ошибка")
                    }
                case .failure(let error):
                    self.showError(error.localizedDescription)
                }
            }
        }
    }
}
