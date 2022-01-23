//
//  CatalogViewController.swift
//  GBShop
//
//  Created by Кирилл Копытин on 23.01.2022.
//

import UIKit

class CatalogViewController: UIViewController {
    @IBOutlet weak var catalogCollectionView: UICollectionView!
    
    private let requestFactory = RequestFactory()
    
    let catalogCollectionViewCellIdentifier = "CatalogCollectionViewCellIdentifier"
    
    var products = [ProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let catalog = requestFactory.makeCatalogRequestFactory()
        catalog.getCatalog(pageNumber: 1, idCategory: 1) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let catalog):
                if catalog.result != 0 {
                    self.products = catalog.products ?? []
                    self.catalogCollectionView.reloadData()
                } else {
                    self.showError(catalog.errorMessage ?? "Неизвестная ошибка")
                }
            case .failure(let error):
                self.showError(error.localizedDescription)
            }
        }
        
        catalogCollectionView.dataSource = self
        catalogCollectionView.delegate = self
        catalogCollectionView.register(UINib(nibName: "CatalogCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: catalogCollectionViewCellIdentifier)
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
}
