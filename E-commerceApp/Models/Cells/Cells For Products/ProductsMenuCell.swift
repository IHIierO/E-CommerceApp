//
//  ProductsMenuCell.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 21.10.2022.
//

import UIKit

class ProductsMenuCell: UICollectionViewCell {
    
    static var reuseId: String = "ProductsMenuCell"
    
    let menuLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        self.layer.cornerRadius = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with itemIdentifier: Int, indexPath: IndexPath, filters: Filter) {
        menuLabel.text = "\(filters.names[indexPath.row])"
    }
    
    private func setConstraints() {
        self.addSubview(menuLabel)
        NSLayoutConstraint.activate([
            menuLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            menuLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            menuLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            menuLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ])
    }
    
}

