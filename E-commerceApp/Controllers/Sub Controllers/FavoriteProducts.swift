//
//  FavoriteProducts.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 18.10.2022.
//

import UIKit

class FavoriteProducts: UIViewController {
    
    var curentFavoriteProduct = products.filter({$0.favorite == true})
    
    let label: UILabel = {
       let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        print("\(curentFavoriteProduct)")
        label.text = curentFavoriteProduct[0].productName
    }
    
    private func setConstraints(){
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            label.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45)
        ])
    }

}
