//
//  EmptyFavoriteProducts.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 18.10.2022.
//

import UIKit

class EmptyFavoriteProducts: UIViewController {
    
    
    let label: UILabel = {
       let label = UILabel()
        label.text = "Вы пока не добавили товары в избранное"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = UIColor(hexString: "#324B3A")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#FDFAF3")
        setConstraints()
    }
    
    private func setConstraints(){
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            label.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45)
        ])
    }

}
