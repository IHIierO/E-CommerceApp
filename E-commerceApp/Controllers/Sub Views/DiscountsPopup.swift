//
//  DiscountsPopup.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 14.10.2022.
//

import UIKit

class DiscountsPopup: UIView {
    
    var moreInfoButtonTappedCallback: (()->())?
    
    private let discountPercent: UILabel = {
        let label = UILabel()
        label.text = "Акция 30%"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let discountDescription: UILabel = {
        let label = UILabel()
        label.text = "Акция 30% на всю косметику бренда Letual"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let discountData = [
    "10",
    "20",
    "30",
    "50",
    
    ]
    
    private let container: UIView = {
       let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 24
        container.layer.shadowColor = UIColor(hexString: "#6A6F6A").cgColor
        container.layer.shadowOpacity = 0.8
        container.layer.shadowOffset = .zero
        container.layer.shadowRadius = 5
        
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    private let closeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
         var config = UIButton.Configuration.plain()
         config.imagePadding = 4
         config.image = UIImage(systemName: "xmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large))
         button.configuration = config
         button.tintColor = .black
         
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
    }()
    private let moreInfoButton: UIButton = {
        let button = UIButton()
        button.configuration = .gray()
        button.configuration?.title = "Подробнее"
        button.configuration?.baseForegroundColor = .black
        button.configuration?.cornerStyle = .capsule
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func animateOut(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        }) { (complite) in
            if complite {
                self.removeFromSuperview()
            }
        }
    }
    @objc private func animateIn(){
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
    @objc private func moreInfoButtonTapped(){
        moreInfoButtonTappedCallback?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.frame = UIScreen.main.bounds
        
        setConstraints()
//        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        closeButton.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
        moreInfoButton.addTarget(self, action: #selector(moreInfoButtonTapped), for: .touchUpInside)
        animateIn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(indexPath: IndexPath) {
        discountPercent.text = "Акция \(discountData[indexPath.row])%"
        discountDescription.text = "Акция \(discountData[indexPath.row])% на всю косметику бренда Letual"
    }
    
    private func setConstraints(){
        self.addSubview(container)
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45)
        ])
        
        container.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        container.addSubview(discountPercent)
        NSLayoutConstraint.activate([
            discountPercent.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            discountPercent.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            discountPercent.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            discountPercent.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.25)
        ])
        
        container.addSubview(moreInfoButton)
        NSLayoutConstraint.activate([
            moreInfoButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            moreInfoButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            moreInfoButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8),
            moreInfoButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.1),
        ])
        
        container.addSubview(discountDescription)
        NSLayoutConstraint.activate([
            discountDescription.topAnchor.constraint(equalTo: discountPercent.bottomAnchor, constant: 0),
            discountDescription.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            discountDescription.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            discountDescription.bottomAnchor.constraint(equalTo: moreInfoButton.topAnchor, constant: 0)
        ])
        
        
    }
    
}
