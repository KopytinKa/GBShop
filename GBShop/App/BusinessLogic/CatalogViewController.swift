//
//  CatalogViewController.swift
//  GBShop
//
//  Created by Кирилл Копытин on 23.01.2022.
//

import UIKit
import Firebase

class CatalogViewController: UIViewController {
    @IBOutlet weak var catalogCollectionView: UICollectionView!
    
    private let requestFactory = RequestFactory()
    
    let catalogCollectionViewCellIdentifier = "CatalogCollectionViewCellIdentifier"
    
    let fromCatalogToProductDetailSegueIdentifier = "fromCatalogToProductDetail"
    
    var products = [ProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchData()
        
        self.catalogCollectionView.dataSource = self
        self.catalogCollectionView.delegate = self
        self.catalogCollectionView.register(UINib(nibName: "CatalogCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: catalogCollectionViewCellIdentifier)
    }
    
    private func fetchData() {
        let catalog = requestFactory.makeCatalogRequestFactory()
        catalog.getCatalog(pageNumber: 1, idCategory: 1) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let catalog):
                if catalog.result != 0 {
                    Crashlytics.crashlytics().log("catalog data success")
                    self.products = catalog.products ?? []
                    self.catalogCollectionView.reloadData()
                } else {
                    let message = catalog.errorMessage ?? "Неизвестная ошибка"
                    Crashlytics.crashlytics().log(message)
                    self.showError(message)
                }
            case .failure(let error):
                Crashlytics.crashlytics().log(error.localizedDescription)
                self.showError(error.localizedDescription)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.fromCatalogToProductDetailSegueIdentifier {
            guard let productDetailViewController = segue.destination as? ProductDetailViewController else {
                assertionFailure("Fatal error")
                return
            }
            guard let indexPath = sender as? IndexPath else { return }
            
            productDetailViewController.productId = products[indexPath.item].id
        }
    }
    
    func assertionFailure(_ message: String) {
        #if DEBUG
            Swift.assertionFailure(message)
        #else
            Crashlytics.crashlytics().log(message)
        #endif
    }
}

extension CatalogViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: catalogCollectionViewCellIdentifier, for: indexPath) as? CatalogCollectionViewCell
        else {
            return UICollectionViewCell()
        }
    
        let product = products[indexPath.row]
        cell.configure(product: product)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: self.fromCatalogToProductDetailSegueIdentifier, sender: indexPath)
    }
}
