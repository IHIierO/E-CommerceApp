//
//  Discounts.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//

import UIKit

class Discounts: UIViewController {
    
    var discountData:[String] = []
    
    private let discountLabel: UILabel = {
        let label = UILabel()
        label.text = "Акция 30%"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Discounts"
        
        setConstraints()
       
    }
    
    func config(indexPath: IndexPath) {
        discountLabel.text = "Акция \(discountData[indexPath.row])%"
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
