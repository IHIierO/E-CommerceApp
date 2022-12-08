//
//  AddToCartPopup.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 08.11.2022.
//

import UIKit

class NotificationPopup: UIView {
    
    private let container = DefaultContainerView()
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(hexString: "#324B3A")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var animationHelpers: AnimationHelpers!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height / 1.2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 6)
        setConstraints()
        animationHelpers = AnimationHelpers(view: self, container: container)
            animationHelpers.notificationPopupAnimateIn()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.animationHelpers.notificationPopupAnimateOut()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(){
        self.addSubview(container)
        container.addSubview(label)
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            container.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        ])
    }
}
