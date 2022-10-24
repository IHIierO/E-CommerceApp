//
//  CartCell.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 24.10.2022.
//

import UIKit

class CartCell: UICollectionViewCell {
    static var reuseId: String = "CartCell"
    
    var stepperCount = 1
    var plusButtonCallback: (()->())?
    var minusButtonCallback: (()->())?
    
    let productImage: UIImageView = {
       let productImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        productImage.image = UIImage(named: "topRated")
        productImage.contentMode = .scaleAspectFill
        productImage.clipsToBounds = true
        
        productImage.translatesAutoresizingMaskIntoConstraints = false
        return productImage
    }()
    let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Куртка Женская"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let priceLabel: UILabel = {
       let label = UILabel()
        label.text = "$125"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let stepperStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let stepperPlusButton: UIButton = {
       let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        var config = UIButton.Configuration.plain()
        config.imagePadding = 4
        config.image = UIImage(systemName: "plus.square.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large))
        button.configuration = config
        button.tintColor = .black
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let stepperMinusButton: UIButton = {
       let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        var config = UIButton.Configuration.plain()
        config.imagePadding = 4
        config.image = UIImage(systemName: "minus.square.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large))
        button.configuration = config
        button.tintColor = .black
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let stepperLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        stepperLabel.text = "\(stepperCount)"
        setConstraints()
        stepperPlusButton.addTarget(self, action: #selector(stepperPlusButtonTapped), for: .touchUpInside)
        stepperMinusButton.addTarget(self, action: #selector(stepperMinusButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func stepperPlusButtonTapped(){
        plusButtonCallback?()
    }
    @objc func stepperMinusButtonTapped(){
        minusButtonCallback?()
    }
    
    func configure(indexPath: IndexPath, products: [Product]){
        productImage.image = UIImage(named: products[indexPath.row].productImage!)
        nameLabel.text = "\(products[indexPath.row].productName) | \(products[indexPath.row].volume)ml"
        priceLabel.text = "\(products[indexPath.row].price) руб."
    }
    
    private func setConstraints() {
        self.addSubview(productImage)
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            productImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            productImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            productImage.heightAnchor.constraint(equalToConstant: self.frame.height - 16),
            productImage.widthAnchor.constraint(equalToConstant: self.frame.width / 3)
        ])
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        self.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        self.addSubview(stepperStackView)
        NSLayoutConstraint.activate([
            stepperStackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            stepperStackView.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 8),
            stepperStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
        ])
        stepperStackView.addSubview(stepperMinusButton)
        NSLayoutConstraint.activate([
            stepperMinusButton.topAnchor.constraint(equalTo: stepperStackView.topAnchor, constant: 0),
            stepperMinusButton.leadingAnchor.constraint(equalTo: stepperStackView.leadingAnchor, constant: 0),
            stepperMinusButton.bottomAnchor.constraint(equalTo: stepperStackView.bottomAnchor, constant: 0),
            stepperMinusButton.widthAnchor.constraint(equalTo: stepperStackView.widthAnchor, multiplier: 1/3)
        ])
        stepperStackView.addSubview(stepperLabel)
        NSLayoutConstraint.activate([
            stepperLabel.topAnchor.constraint(equalTo: stepperStackView.topAnchor, constant: 0),
            stepperLabel.centerXAnchor.constraint(equalTo: stepperStackView.centerXAnchor),
            stepperLabel.bottomAnchor.constraint(equalTo: stepperStackView.bottomAnchor, constant: 0),
            stepperLabel.widthAnchor.constraint(equalTo: stepperStackView.widthAnchor, multiplier: 1/3)
        ])
        stepperStackView.addSubview(stepperPlusButton)
        NSLayoutConstraint.activate([
            stepperPlusButton.topAnchor.constraint(equalTo: stepperStackView.topAnchor, constant: 0),
            stepperPlusButton.trailingAnchor.constraint(equalTo: stepperStackView.trailingAnchor, constant: 0),
            stepperPlusButton.bottomAnchor.constraint(equalTo: stepperStackView.bottomAnchor, constant: 0),
            stepperPlusButton.widthAnchor.constraint(equalTo: stepperStackView.widthAnchor, multiplier: 1/3)
        ])
    }
   
}

