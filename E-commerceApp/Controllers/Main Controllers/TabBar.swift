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
            viewControllers: ShoppingCart(),
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
