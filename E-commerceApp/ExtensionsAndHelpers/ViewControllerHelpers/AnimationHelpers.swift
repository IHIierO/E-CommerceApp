//
//  AnimationHelpers.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 08.12.2022.
//

import UIKit

class AnimationHelpers: NSObject{
    
    var view = UIView()
    var container = DefaultContainerView()
    
    init(view: UIView, container: DefaultContainerView){
       super.init()
        self.view = view
        self.container = container
    }
    
    //MARK: - animateIn
    @objc func animateIn(){
        container.transform = CGAffineTransform(translationX: 0, y: -view.frame.height)
        view.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.view.alpha = 1
        })
    }
    
    //MARK: - animateOut
    @objc func animateOut(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            self.view.alpha = 0
        }) { (complite) in
            if complite {
                self.view.removeFromSuperview()
            }
        }
    }
    //MARK: - notificationPopupAnimateOut
    @objc func notificationPopupAnimateOut(){
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.view.alpha = 0
        }) { (complite) in
            if complite {
                self.view.removeFromSuperview()
            }
        }
    }
    //MARK: - notificationPopupAnimateIn
    @objc func notificationPopupAnimateIn(){
        self.container.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        self.view.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.view.alpha = 1
        })
    }
}
