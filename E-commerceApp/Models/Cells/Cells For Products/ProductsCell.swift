//
//  ProductsCell.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 21.10.2022.
//

import UIKit

class ProductsCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseId: String = "ProductsCell"
    var addToShoppingCardCallback: (()->())?
    var favoriteButtonTapAction : (()->())?
    
    let favoriteButton: UIButton = {
       let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        var config = UIButton.Configuration.plain()
        config.imagePadding = 4
        config.image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large))
        button.configuration = config
        button.tintColor = .red
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let addToShoppingCard: UIButton = {
       let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        var config = UIButton.Configuration.plain()
        config.imagePadding = 4
        config.image = UIImage(systemName: "cart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large))
        button.configuration = config
        button.tintColor = .black
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let productImage: UIImageView = {
       let productImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        productImage.image = UIImage(named: "topRated")
        productImage.contentMode = .scaleAspectFill
        productImage.layer.cornerRadius = 8
        productImage.clipsToBounds = true
        
        productImage.translatesAutoresizingMaskIntoConstraints = false
        return productImage
    }()
    let priceLabel: UILabel = {
       let label = UILabel()
        label.text = "$125"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Куртка Женская"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        self.backgroundColor = .red
        
        favoriteButton.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        addToShoppingCard.addTarget(self, action: #selector(addToShoppingCardTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func addToFavorite(){
        favoriteButtonTapAction?()
    }
    @objc func addToShoppingCardTap(){
        addToShoppingCardCallback?()
    }
    
    func configure(with itemIdentifier: Int, indexPath: IndexPath, products: [Product]) {
        
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        self.clipsToBounds = false
        
        productImage.image = UIImage(named: "\(products[indexPath.row].productImage[0])")
        nameLabel.text = "\(products[indexPath.row].productName)"
        priceLabel.text = "\(products[indexPath.row].price) руб."
        
        if Persons.ksenia.favoriteProducts.contains(where: { product in
            product.id == products[indexPath.row].id
        }) {
            favoriteButton.configuration?.image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large))
        }else{
            favoriteButton.configuration?.image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large))
        }
        
        if Persons.ksenia.productsInCart.contains(where: { product in
            product.id == products[indexPath.row].id
        }){
            addToShoppingCard.configuration?.image = UIImage(systemName: "cart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large))
        }else{
            addToShoppingCard.configuration?.image = UIImage(systemName: "cart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large))
        }
    }
    
    private func setConstraints(){
        self.addSubview(productImage)
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            productImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            productImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            productImage.heightAnchor.constraint(equalToConstant: self.frame.height - 40),
        ])
        
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 0),
        ])
        
        self.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
        ])
        
        self.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: productImage.topAnchor, constant: 4),
            favoriteButton.trailingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: -4),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.addSubview(addToShoppingCard)
        NSLayoutConstraint.activate([
            addToShoppingCard.bottomAnchor.constraint(equalTo: productImage.bottomAnchor, constant: -4),
            addToShoppingCard.leadingAnchor.constraint(equalTo: productImage.leadingAnchor, constant: 4),
            addToShoppingCard.widthAnchor.constraint(equalToConstant: 40),
            addToShoppingCard.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}


