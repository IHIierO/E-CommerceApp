//
//  EmptyFavoriteProducts.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 18.10.2022.
//

import UIKit

class EmptyFavoriteProducts: UIViewController {
    
    let label = DefaultUILabel(inputText: "Вы пока не добавили товары в избранное", fontSize: 30, fontWeight: .regular)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setConstraints()
    }
    
    private func setupViewController(){
        view.backgroundColor = UIColor(hexString: "#FDFAF3")
        label.numberOfLines = 0
        label.textColor = UIColor(hexString: "#324B3A")
        BackButton(vc: self).createBackButton()
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
