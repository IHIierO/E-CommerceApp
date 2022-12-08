//
//  CartCell.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 07.11.2022.
//

import UIKit

class CartCell: UITableViewCell {
    
    static var reuseId: String = "CartCell2"
    
    var plusButtonCallback: (()->())?
    var minusButtonCallback: (()->())?
    
    let containerView: UIView = {
       let containerView = UIView()
        containerView.backgroundColor = UIColor(hexString: "#FDFAF3")
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
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
    let nameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(hexString: "#324B3A")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let priceLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(hexString: "#324B3A")
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
        config.baseForegroundColor = UIColor(hexString: "#324B3A")
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
        config.baseForegroundColor = .lightGray
        button.configuration = config
        button.tintColor = .black
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let stepperLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#324B3A")
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(hexString: "#324B3A").cgColor
        label.layer.cornerRadius = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell(){
        self.selectionStyle = .none
        self.backgroundColor = .clear
        setConstraints()
        stepperPlusButton.addTarget(self, action: #selector(stepperPlusButtonTapped), for: .touchUpInside)
        stepperMinusButton.addTarget(self, action: #selector(stepperMinusButtonTapped), for: .touchUpInside)
    }
    
    @objc func stepperPlusButtonTapped(){
        plusButtonCallback?()
    }
    @objc func stepperMinusButtonTapped(){
        minusButtonCallback?()
    }
    
    func configure(indexPath: IndexPath, products: [Product]){
        productImage.image = UIImage(named: products[indexPath.row].productImage[0])
        nameLabel.text = products[indexPath.row].productName
        CellsHelpers.priceLabelText(indexPath: indexPath, products: products, priceLabel: priceLabel)
        
        if Persons.ksenia.productsInCart[indexPath.row].count != 1 {
            stepperMinusButton.configuration?.baseForegroundColor = UIColor(hexString: "#324B3A")
        }else{
            stepperMinusButton.configuration?.baseForegroundColor = .lightGray
        }
        if Persons.ksenia.productsInCart[indexPath.row].count != 10 {
            stepperPlusButton.configuration?.baseForegroundColor = UIColor(hexString: "#324B3A")
        }else{
            stepperPlusButton.configuration?.baseForegroundColor = .lightGray
        }
    }
    private func setConstraints() {
        [containerView, productImage, nameLabel, priceLabel, stepperStackView].forEach{
            self.contentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            
            productImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            productImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 18),
            productImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            productImage.widthAnchor.constraint(equalToConstant: self.frame.width / 3),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            stepperStackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            stepperStackView.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 8),
            stepperStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
        ])
        
        [stepperMinusButton, stepperLabel, stepperPlusButton].forEach{
            stepperStackView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            stepperMinusButton.topAnchor.constraint(equalTo: stepperStackView.topAnchor, constant: 0),
            stepperMinusButton.leadingAnchor.constraint(equalTo: stepperStackView.leadingAnchor, constant: 0),
            stepperMinusButton.bottomAnchor.constraint(equalTo: stepperStackView.bottomAnchor, constant: 0),
            stepperMinusButton.widthAnchor.constraint(equalTo: stepperStackView.widthAnchor, multiplier: 1/3),
            
            stepperLabel.topAnchor.constraint(equalTo: stepperStackView.topAnchor, constant: 0),
            stepperLabel.centerXAnchor.constraint(equalTo: stepperStackView.centerXAnchor),
            stepperLabel.bottomAnchor.constraint(equalTo: stepperStackView.bottomAnchor, constant: 0),
            stepperLabel.widthAnchor.constraint(equalTo: stepperStackView.widthAnchor, multiplier: 1/3),
            
            stepperPlusButton.topAnchor.constraint(equalTo: stepperStackView.topAnchor, constant: 0),
            stepperPlusButton.trailingAnchor.constraint(equalTo: stepperStackView.trailingAnchor, constant: 0),
            stepperPlusButton.bottomAnchor.constraint(equalTo: stepperStackView.bottomAnchor, constant: 0),
            stepperPlusButton.widthAnchor.constraint(equalTo: stepperStackView.widthAnchor, multiplier: 1/3)
        ])
    }
}
