//
//  OrderPopup.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 08.11.2022.
//

import UIKit

class OrderPopup: UIView {
    
    var orderButtonTappedCallback: (()->())?
    
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
    
    let blurEffect = UIBlurEffect(style: .dark)
    lazy var blurEffectView = UIVisualEffectView()
    
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
    private let orderButton: UIButton = {
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
        orderButtonTappedCallback?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .clear
        self.frame = UIScreen.main.bounds
        
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        
        setConstraints()
//        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        closeButton.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
        orderButton.addTarget(self, action: #selector(moreInfoButtonTapped), for: .touchUpInside)
        animateIn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func config(indexPath: IndexPath) {
//        discountPercent.text = "Акция \(discountData[indexPath.row])%"
//        discountDescription.text = "Акция \(discountData[indexPath.row])% на всю косметику бренда Letual"
//    }
    
    private func setConstraints(){
        self.addSubview(container)
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65)
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
        
        container.addSubview(orderButton)
        NSLayoutConstraint.activate([
            orderButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            orderButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            orderButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8),
            orderButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.1),
        ])
        
        container.addSubview(discountDescription)
        NSLayoutConstraint.activate([
            discountDescription.topAnchor.constraint(equalTo: discountPercent.bottomAnchor, constant: 0),
            discountDescription.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            discountDescription.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            discountDescription.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: 0)
        ])
        
        
    }
    
}
