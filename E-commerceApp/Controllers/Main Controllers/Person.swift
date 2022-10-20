//
//  Person.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//

import UIKit

class Person: UIViewController {
    
    private let button: UIButton = {
        let button = UIButton()
        button.configuration = .gray()
        button.configuration?.title = "Favorite"
        button.configuration?.baseForegroundColor = .black
        button.configuration?.cornerStyle = .capsule
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        button.addTarget(self, action: #selector(goToFavorite), for: .touchUpInside)
    }

    @objc func goToFavorite(){
        navigationController?.pushViewController(FavoriteProducts(), animated: true)
    }
}
