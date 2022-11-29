//
//  AddToCartPopup.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 08.11.2022.
//

import UIKit

class NotificationPopup: UIView {
    
    private let container: UIView = {
       let container = UIView()
        container.backgroundColor = UIColor(hexString: "#FDFAF3")
        container.layer.cornerRadius = 20
        container.layer.shadowColor = UIColor(hexString: "#6A6F6A").cgColor
        container.layer.shadowOpacity = 0.8
        container.layer.shadowOffset = .zero
        container.layer.shadowRadius = 5
        
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(hexString: "#324B3A")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc func animateOut(){
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
            self.alpha = 0
        }) { (complite) in
            if complite {
                self.removeFromSuperview()
            }
        }
    }
    @objc private func animateIn(){
        self.container.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
        self.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height / 1.2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 6)
        setConstraints()
        animateIn()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.animateOut()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(){
        self.addSubview(container)
        NSLayoutConstraint.activate([
            //container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            container.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1)
        ])
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        ])
    }
}
