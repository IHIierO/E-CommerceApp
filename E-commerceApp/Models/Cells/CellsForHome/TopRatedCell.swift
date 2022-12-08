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
    let favoriteButton = DefaultFavoriteButton()
    let addToShoppingCard = DefaultAddToShoppingCard()
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
        CellsHelpers.priceLabelText(indexPath: indexPath, products: products, priceLabel: priceLabel)
        CellsHelpers.buttonsImageConfiguration(indexPath: indexPath, products: products, favoriteButton: favoriteButton, addToShoppingCard: addToShoppingCard)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setConstraints()
    }
    
    private func setupCell(){
        self.backgroundColor = UIColor(hexString: "#FDFAF3")
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        self.clipsToBounds = false
        
        favoriteButton.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        addToShoppingCard.addTarget(self, action: #selector(addToShoppingCardTap), for: .touchUpInside)
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
        [topRatedImage, favoriteButton, addToShoppingCard, nameLabel, priceLabel].forEach{
            self.addSubview($0)
        }
        NSLayoutConstraint.activate([
            topRatedImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            topRatedImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            topRatedImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            topRatedImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            
            favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            
            addToShoppingCard.bottomAnchor.constraint(equalTo: topRatedImage.bottomAnchor, constant: -4),
            addToShoppingCard.leadingAnchor.constraint(equalTo: topRatedImage.leadingAnchor, constant: 4),
            addToShoppingCard.widthAnchor.constraint(equalToConstant: 40),
            addToShoppingCard.heightAnchor.constraint(equalToConstant: 40),
       
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: topRatedImage.bottomAnchor, constant: 0),
       
            priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
        ])
    } 
}

