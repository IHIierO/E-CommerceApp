//
//  ProductCard.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//

import UIKit

class ProductCard: UIViewController {
    
    var discountData:[String] = []
    
    let discountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setConstraints()
       
    }
    
    func config(indexPath: IndexPath) {
        discountLabel.text = products[0].productName
    }

    private func setConstraints(){
        view.addSubview(discountLabel)
        NSLayoutConstraint.activate([
            discountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            discountLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            discountLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            discountLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45)
        ])
    }
    
}
