//
//  TopRatedCell.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//

import UIKit

class TopRatedCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseId: String = "TopRatedCell"
    
    var favoriteButtonTapAction : (()->())?
    var addToShoppingCardCallback: (()->())?
    let topRatedImage: UIImageView = {
       let topRatedImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        topRatedImage.contentMode = .scaleAspectFit
        topRatedImage.layer.cornerRadius = 8
        topRatedImage.clipsToBounds = true
        
        topRatedImage.translatesAutoresizingMaskIntoConstraints = false
        return topRatedImage
    }()
    let favoriteButton: UIButton = {
       let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        var config = UIButton.Configuration.plain()
        config.imagePadding = 4
        config.image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large))
        button.configuration = config
        button.tintColor = .red
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let addToShoppingCard: UIButton = {
       let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        var config = UIButton.Configuration.plain()
        config.imagePadding = 4
        config.image = UIImage(systemName: "cart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light))
        button.configuration = config
        button.tintColor = UIColor(hexString: "#324B3A")
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let priceLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(hexString: "#324B3A")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(hexString: "#324B3A")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(with itemIdentifier: Int, indexPath: IndexPath, products: [Product]) {
        topRatedImage.image = UIImage(named: products[indexPath.row].productImage[0])
        nameLabel.text = products[indexPath.row].productName
        
        if products[indexPath.row].discount != nil {
            let discontPrice = (products[indexPath.row].price * (100 - (products[indexPath.row].discount ?? 100))/100)
            let discontPriceLabel = "\(discontPrice) \(products[indexPath.row].price) ₽"
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: discontPriceLabel)
            attributedString.createStringtToStrike(stringtToStrike: "\(products[indexPath.row].price)")
            attributedString.createStringtToColor(stringtToColor: "\(discontPrice)", color: .red)
            attributedString.createStringtToColor(stringtToColor: "₽", color: UIColor(hexString: "#324B3A"))
            priceLabel.attributedText = attributedString
        }else{
            priceLabel.text = "\(products[indexPath.row].price) ₽"
        }
        
        if Persons.ksenia.favoriteProducts.contains(where: { product in
            product.id == products[indexPath.row].id
        }) {
            favoriteButton.configuration?.image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light))
        }else{
            favoriteButton.configuration?.image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light))
        }
        if Persons.ksenia.productsInCart.contains(where: { product in
            product.id == products[indexPath.row].id
        }){
            addToShoppingCard.configuration?.image = UIImage(systemName: "cart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large))
        }else{
            addToShoppingCard.configuration?.image = UIImage(systemName: "cart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hexString: "#FDFAF3")
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        self.clipsToBounds = false
        favoriteButton.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        addToShoppingCard.addTarget(self, action: #selector(addToShoppingCardTap), for: .touchUpInside)
        setConstraints()
    }
    
    @objc func addToFavorite(){
        favoriteButtonTapAction?()
    }
    @objc func addToShoppingCardTap(){
        addToShoppingCardCallback?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(){
        self.addSubview(topRatedImage)
        NSLayoutConstraint.activate([
            topRatedImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            topRatedImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            topRatedImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            topRatedImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8)
        ])
        
        self.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.addSubview(addToShoppingCard)
        NSLayoutConstraint.activate([
            addToShoppingCard.bottomAnchor.constraint(equalTo: topRatedImage.bottomAnchor, constant: -4),
            addToShoppingCard.leadingAnchor.constraint(equalTo: topRatedImage.leadingAnchor, constant: 4),
            addToShoppingCard.widthAnchor.constraint(equalToConstant: 40),
            addToShoppingCard.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: topRatedImage.bottomAnchor, constant: 0),
        ])
        
        self.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
        ])
    }
    
}

