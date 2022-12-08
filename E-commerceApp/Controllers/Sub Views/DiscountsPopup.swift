//
//  DiscountsPopup.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 14.10.2022.
//

import UIKit

class DiscountsPopup: UIView {
    
    var moreInfoButtonTappedCallback: (()->())?
    var animationHelpers: AnimationHelpers!
    
    private let discountPercent: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(hexString: "#324B3A")
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
        label.textColor = UIColor(hexString: "#324B3A")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let discountData = [
    "10",
    "20",
    "30",
    "50",
    ]
    
    private let container = DefaultContainerView()
    private let closeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
         var config = UIButton.Configuration.plain()
         config.imagePadding = 4
         config.image = UIImage(systemName: "xmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large))
         button.configuration = config
         button.tintColor = UIColor(hexString: "#324B3A")
         
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
    }()
    private let moreInfoButton = DefaultButton(buttonTitle: "Подробнее")
    let blurEffect = UIBlurEffect(style: .regular)
    lazy var blurEffectView = UIVisualEffectView()
    
    @objc private func moreInfoButtonTapped(){
        moreInfoButtonTappedCallback?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.frame = UIScreen.main.bounds
        
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        
        setConstraints()
        animationHelpers = AnimationHelpers(view: self, container: container)
        self.addGestureRecognizer(UITapGestureRecognizer(target: animationHelpers, action: #selector(animationHelpers.animateOut)))
        closeButton.addTarget(animationHelpers, action: #selector(animationHelpers.animateOut), for: .touchUpInside)
        moreInfoButton.addTarget(self, action: #selector(moreInfoButtonTapped), for: .touchUpInside)
        animationHelpers.animateIn()
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
        [closeButton, discountPercent, moreInfoButton, discountDescription].forEach{
            container.addSubview($0)
        }
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45),
       
            closeButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            
            discountPercent.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            discountPercent.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            discountPercent.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            discountPercent.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.25),
            
            moreInfoButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            moreInfoButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            moreInfoButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8),
            moreInfoButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.1),
            
            discountDescription.topAnchor.constraint(equalTo: discountPercent.bottomAnchor, constant: 0),
            discountDescription.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            discountDescription.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            discountDescription.bottomAnchor.constraint(equalTo: moreInfoButton.topAnchor, constant: 0)
        ])
    }
}
