//
//  CartCell2.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 07.11.2022.
//

import UIKit

class CartCellTV: UITableViewCell {
    
    static var reuseId: String = "CartCell2"
    
    var plusButtonCallback: (()->())?
    var minusButtonCallback: (()->())?
    
    let containerView: UIView = {
       let containerView = UIView()
        containerView.backgroundColor = UIColor(hexString: "#FDFAF3")
//        containerView.layer.cornerRadius = 8
//        containerView.clipsToBounds = true
//        containerView.layer.shadowRadius = 8
//        containerView.layer.shadowOpacity = 0.8
//        containerView.layer.shadowOffset = .zero
//        containerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
//        containerView.layer.masksToBounds = false
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
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//        
//    }
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
        
    }
    private func setConstraints() {
        self.contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
        self.contentView.addSubview(productImage)
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            productImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 18),
            productImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            productImage.widthAnchor.constraint(equalToConstant: self.frame.width / 3)
        ])
        self.contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        self.contentView.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        self.contentView.addSubview(stepperStackView)
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
