//
//  CartCell.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 24.10.2022.
//

import UIKit

extension String {
        func createAttributedString(stringtToStrike: String) -> NSMutableAttributedString {
            let attributedString = NSMutableAttributedString(string: self)
            let range = attributedString.mutableString.range(of: stringtToStrike)
            attributedString.addAttributes([NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue], range: range)
            return attributedString
        } }

class CartCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    static var reuseId: String = "CartCell"
    
    var plusButtonCallback: (()->())?
    var minusButtonCallback: (()->())?
    var pan: UIPanGestureRecognizer!
    
    let containerView: UIView = {
       let containerView = UIView()
        containerView.backgroundColor = .lightGray
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    let productImage: UIImageView = {
       let productImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        productImage.image = UIImage(named: "topRated")
        productImage.contentMode = .scaleAspectFill
        productImage.clipsToBounds = true
        
        productImage.translatesAutoresizingMaskIntoConstraints = false
        return productImage
    }()
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
    let discontLabel: UIImageView = {
       let label = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        label.image = UIImage(systemName: "percent")
        
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
    let deleteLabel: UILabel = {
       let label = UILabel()
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large))
        let fullString = NSMutableAttributedString(attachment: imageAttachment)
        label.attributedText = fullString
        label.backgroundColor = .red
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (pan.state == UIGestureRecognizer.State.changed) {
            let p: CGPoint = pan.translation(in: self)
            let width = self.contentView.frame.width
            let height = self.contentView.frame.height
            self.contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height);
            self.deleteLabel.frame = CGRect(x: p.x + width + deleteLabel.frame.size.width, y: 0, width: 100, height: height)
        }
    }
    
    @objc func onPan(_ pan: UIPanGestureRecognizer) {
        if pan.state == UIGestureRecognizer.State.began {

        } else if pan.state == UIGestureRecognizer.State.changed {
        self.setNeedsLayout()
      } else {
        if abs(pan.velocity(in: self).x) > 500 {
          let collectionView: UICollectionView = self.superview as! UICollectionView
          let indexPath: IndexPath = collectionView.indexPathForItem(at: self.center)!
          collectionView.delegate?.collectionView!(collectionView, performAction: #selector(onPan(_:)), forItemAt: indexPath, withSender: nil)
        } else {
          UIView.animate(withDuration: 0.2, animations: {
            self.setNeedsLayout()
            self.layoutIfNeeded()
          })
        }
      }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
       return true
     }

     override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
       return abs((pan.velocity(in: pan.view)).x) > abs((pan.velocity(in: pan.view)).y)
     }
    
    private func setupCell(){
        setConstraints()
        stepperPlusButton.addTarget(self, action: #selector(stepperPlusButtonTapped), for: .touchUpInside)
        stepperMinusButton.addTarget(self, action: #selector(stepperMinusButtonTapped), for: .touchUpInside)
        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        pan.delegate = self
        self.addGestureRecognizer(pan)
    }
    
    @objc func stepperPlusButtonTapped(){
        plusButtonCallback?()
    }
    @objc func stepperMinusButtonTapped(){
        minusButtonCallback?()
    }
    
    func configure(indexPath: IndexPath, products: [Product]){
        productImage.image = UIImage(named: products[indexPath.row].productImage)
        nameLabel.text = "\(products[indexPath.row].productName) | \(products[indexPath.row].volume)ml"
        
        if products[indexPath.row].discount != nil {
            let discontPrice = (products[indexPath.row].price * (100 - (products[indexPath.row].discount ?? 100))/100)
            priceLabel.attributedText = "\(products[indexPath.row].price)  \(discontPrice) руб.".createAttributedString(stringtToStrike: "\(products[indexPath.row].price)")
        }else{
            priceLabel.text = "\(products[indexPath.row].price) руб."
        }
    }
    
    private func setConstraints() {
        self.contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        self.contentView.addSubview(productImage)
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            productImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            productImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            productImage.heightAnchor.constraint(equalToConstant: self.frame.height - 16),
            productImage.widthAnchor.constraint(equalToConstant: self.frame.width / 3)
        ])
        self.contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        self.contentView.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        self.contentView.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: productImage.topAnchor, constant: 4),
            favoriteButton.trailingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: -4),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        self.contentView.addSubview(discontLabel)
        NSLayoutConstraint.activate([
            discontLabel.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 4),
            discontLabel.trailingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: -12),
            discontLabel.widthAnchor.constraint(equalToConstant: 20),
            discontLabel.heightAnchor.constraint(equalToConstant: 20)
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
        self.insertSubview(deleteLabel, belowSubview: self.contentView)
    }
}

