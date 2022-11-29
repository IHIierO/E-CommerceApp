//
//  TabBar.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//

import UIKit

class TabBar: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarConfig()
        setTabBarAppearance()
    }
    
    private func tabBarConfig(){
        let homeController = createNavigationControllers(
            viewControllers: Home(),
            tabBarItemName: "Main",
            tabBarItemImage: "house",
            tabBarItemBage: nil,
            tag: 0
        )
        let shoppingCartViewController = createNavigationControllers(
            viewControllers: ShoppingCartTV(),
            tabBarItemName: "Корзина",
            tabBarItemImage: "cart",
            tabBarItemBage: nil,
            tag: 1
        )
        let searchAndListViewController = createNavigationControllers(
            viewControllers: SearchAndList(),
            tabBarItemName: "Search",
            tabBarItemImage: "doc.text.magnifyingglass",
            tabBarItemBage: nil,
            tag: 2
        )
        let personViewController = createNavigationControllers(
            viewControllers: Person(),
            tabBarItemName: "Person",
            tabBarItemImage: "person",
            tabBarItemBage: nil,
            tag: 3
        )
        viewControllers = [homeController,searchAndListViewController, shoppingCartViewController, personViewController]
    }
    
    private func createNavigationControllers(viewControllers: UIViewController, tabBarItemName: String, tabBarItemImage: String, tabBarItemBage: String?, tag: Int) -> UINavigationController{
        let tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: tabBarItemImage), tag: tag)
        tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: .zero, bottom: -10, right: .zero)
        tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 10 )
        tabBarItem.badgeValue = tabBarItemBage
        let navigationController = UINavigationController(rootViewController: viewControllers)
        navigationController.tabBarItem = tabBarItem
        return navigationController
    }
    
    private func setTabBarAppearance(){
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.isTranslucent = true
        
        let customLayer = CAShapeLayer()
        customLayer.path = .init(rect: CGRect(x: 0, y: -10, width: self.tabBar.bounds.width, height: self.tabBar.bounds.height * 2), transform: .none)
        tabBar.layer.insertSublayer(customLayer, at: 0)
        customLayer.fillColor = UIColor(hexString: "#FDFAF3").cgColor
        customLayer.shadowRadius = 3
        customLayer.shadowOpacity = 0.8
        customLayer.shadowOffset = .zero
        customLayer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        tabBar.tintColor = UIColor(hexString: "#324B3A")
        tabBar.unselectedItemTintColor = UIColor(hexString: "#393C39")
        
    }
    
//    private func createPath() -> CGPath {
//        let cornerRad: CGFloat = 30.0
//        let topLeftArc: CGPoint = CGPoint(x: self.tabBar.bounds.minX + cornerRad, y: self.tabBar.bounds.minY + cornerRad - 5)
//        let topRightArc: CGPoint = CGPoint(x: self.tabBar.bounds.maxX - cornerRad, y: self.tabBar.bounds.minY + cornerRad - 5)
//        let botRightArc: CGPoint = CGPoint(x: self.tabBar.bounds.maxX - cornerRad, y: self.tabBar.bounds.maxY - cornerRad + 20)
//        let botLeftArc: CGPoint = CGPoint(x: self.tabBar.bounds.minX + cornerRad, y: self.tabBar.bounds.maxY - cornerRad + 20)
//        
//        let path = UIBezierPath()
//        
//        // start point
//        path.move(to: CGPoint(x: self.tabBar.bounds.minX, y: self.tabBar.bounds.minY + cornerRad))
//        
//        // topLeftArc
//        path.addArc(withCenter: topLeftArc, radius: cornerRad, startAngle: .pi * 1.0, endAngle: .pi * 1.5, clockwise: true)
//        
//        // topRightArc
//        path.addArc(withCenter: topRightArc, radius: cornerRad, startAngle: -.pi * 0.5, endAngle: 0.0, clockwise: true)
//        
//        // botRightArc
//        path.addArc(withCenter: botRightArc, radius: cornerRad, startAngle: 0.0, endAngle: .pi * 0.5, clockwise: true)
//        
//        // botLeftArc
//        path.addArc(withCenter: botLeftArc, radius: cornerRad, startAngle: .pi * 0.5, endAngle: .pi * 1.0, clockwise: true)
//        
//        path.close()
//        
//        return path.cgPath
//    }
  
    func hideTabBar() {
        self.tabBar.isHidden = true
    }
    func showTabBar() {
        self.tabBar.isHidden = false
    }
    func changeBageValue(){
        if let tabBarItems = self.tabBar.items{
            let i = tabBarItems[2]
            i.badgeValue = Persons.ksenia.productsInCart.count > 0 ? "\(Persons.ksenia.productsInCart.count)" : nil
        }
    }
}
