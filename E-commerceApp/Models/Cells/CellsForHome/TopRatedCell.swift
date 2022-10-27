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
    
    let topRatedImage: UIImageView = {
       let topRatedImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        topRatedImage.image = UIImage(named: "topRated")
        topRatedImage.contentMode = .scaleAspectFill
//        flowerImage.layer.cornerRadius = 15
//        flowerImage.clipsToBounds = true
        
        topRatedImage.translatesAutoresizingMaskIntoConstraints = false
        return topRatedImage
    }()
    
    let favoriteButton: UIButton = {
       let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        var config = UIButton.Configuration.plain()
        config.imagePadding = 4
        config.image = UIImage(systemName: "heart.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large))
        button.configuration = config
        button.tintColor = .red
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    func configure(with itemIdentifier: Int, indexPath: IndexPath, products: [Product]) {
        topRatedImage.image = UIImage(named: products[indexPath.row].productImage)
        nameLabel.text = products[indexPath.row].productName
        priceLabel.text = "\(products[indexPath.row].price) руб."
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        favoriteButton.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        
        setConstraints()
    }
    
    @objc func addToFavorite(){
        favoriteButtonTapAction?()
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
            topRatedImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
        
        self.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            favoriteButton.widthAnchor.constraint(equalToConstant: 60),
            favoriteButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
        self.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
}

