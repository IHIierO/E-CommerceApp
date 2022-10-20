//
//  NewestCell.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//

import UIKit

class NewestCell: UICollectionViewCell, SelfConfiguringCell {
    
    var productData: [Product] = []
   
    static var reuseId: String = "CollectionsCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Men"
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionImage: UIImageView = {
        let collectionImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        collectionImage.image = UIImage(named: "men")
        collectionImage.contentMode = .scaleAspectFill
        
        collectionImage.translatesAutoresizingMaskIntoConstraints = false
        return collectionImage
    }()
    
    let imageData = [
    "kid", "men", "women","kid", "men", "women","kid", "men",
    ]
    
    func configure(with itemIdentifier: Int, indexPath: IndexPath, products: [Product]) {
        collectionImage.image = UIImage(named: "\(products[indexPath.row].productImage!)")
        label.text = "\(products[indexPath.row].productName)"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(){
        self.addSubview(collectionImage)
        NSLayoutConstraint.activate([
            collectionImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            collectionImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            collectionImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            collectionImage.heightAnchor.constraint(equalToConstant: self.frame.height - 20),
            collectionImage.widthAnchor.constraint(equalToConstant: self.frame.width)
        ])
        
        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: collectionImage.bottomAnchor, constant: 2),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2)
        ])
    }
}

