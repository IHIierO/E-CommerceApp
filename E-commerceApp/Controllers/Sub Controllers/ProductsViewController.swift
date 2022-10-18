//
//  ProductsViewController.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 17.10.2022.
//

import UIKit

class ProductsViewController: UIViewController {
    
    let productImage: UIImageView = {
       let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        setupConstraints()
    }
    
    private func setupConstraints(){
        view.addSubview(productImage)
        NSLayoutConstraint.activate([
            productImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            productImage.widthAnchor.constraint(equalToConstant: 200),
            productImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
