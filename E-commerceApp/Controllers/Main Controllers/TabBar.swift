//
//  TabBar.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//

import UIKit

class TabBar: UITabBarController{
    
    let addNewFlowerButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarConfig()
//        setTabBarAppearance()
//        setupAddNewFlowerButton()
    }
    
    private func tabBarConfig(){
        
        let homeController = createNavigationControllers(
            viewControllers: Home(),
            tabBarItemName: "Main",
            tabBarItemImage: "house"
        )
        let shoppingCartViewController = createNavigationControllers(
            viewControllers: ShoppingCart(),
            tabBarItemName: "ShoppingCart",
            tabBarItemImage: "heart"
        )
        
        let searchAndListViewController = createNavigationControllers(
            viewControllers: SerchAndList(),
            tabBarItemName: "Search",
            tabBarItemImage: "doc.text.magnifyingglass"
        )
        
        let personViewController = createNavigationControllers(
            viewControllers: Person(),
            tabBarItemName: "Person",
            tabBarItemImage: "person"
        )
        
        viewControllers = [homeController,searchAndListViewController, shoppingCartViewController, personViewController]
    }
    
    private func createNavigationControllers(viewControllers: UIViewController, tabBarItemName: String, tabBarItemImage: String) -> UINavigationController{
        
        let tabBarItem = UITabBarItem(title: tabBarItemName, image: UIImage(systemName: tabBarItemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 10 )
        let navigationController = UINavigationController(rootViewController: viewControllers)
        navigationController.tabBarItem = tabBarItem
        
        return navigationController
    }
    
    private func setTabBarAppearance(){
        
        let customLayer = CAShapeLayer()
        customLayer.path = createPath()
        tabBar.layer.insertSublayer(customLayer, at: 0)
        
        customLayer.fillColor = UIColor(hexString: "#CFD9CE").cgColor
        
        tabBar.tintColor = UIColor(hexString: "#477940")
        tabBar.unselectedItemTintColor = UIColor(hexString: "#393C39")
    }
    
    private func createPath() -> CGPath {
        
        let cornerRad: CGFloat = 30.0
        let height: CGFloat = 47.0
        let centerWidth = self.tabBar.frame.width / 2
        let topLeftArc: CGPoint = CGPoint(x: self.tabBar.bounds.minX + cornerRad + 10, y: self.tabBar.bounds.minY + cornerRad)
        let topRightArc: CGPoint = CGPoint(x: self.tabBar.bounds.maxX - cornerRad - 10, y: self.tabBar.bounds.minY + cornerRad)
        let botRightArc: CGPoint = CGPoint(x: self.tabBar.bounds.maxX - cornerRad - 10, y: self.tabBar.bounds.maxY - cornerRad + 20)
        let botLeftArc: CGPoint = CGPoint(x: self.tabBar.bounds.minX + cornerRad + 10, y: self.tabBar.bounds.maxY - cornerRad + 20)
        
        let path = UIBezierPath()
        
        // start point
        path.move(to: CGPoint(x: self.tabBar.bounds.minX + 10, y: self.tabBar.bounds.minY + cornerRad))
        
        // topLeftArc
        path.addArc(withCenter: topLeftArc, radius: cornerRad, startAngle: .pi * 1.0, endAngle: .pi * 1.5, clockwise: true)
        
        // add line to finish point
        path.addLine(to: CGPoint(x: (centerWidth - height * 2) + 40, y: 0))
        
        // first curve down
        path.addCurve(to: CGPoint(x: centerWidth, y: height),
                      controlPoint1: CGPoint(x: (centerWidth - 33), y: 2),
                      controlPoint2: CGPoint(x: (centerWidth - 37), y: height + 2))
        
        // second curve up
        path.addCurve(to: CGPoint(x: centerWidth - 40 + height * 2, y: 0),
                      controlPoint1: CGPoint(x: (centerWidth + 37), y: height + 2),
                      controlPoint2: CGPoint(x: (centerWidth + 33), y: 2))
        
        // topRightArc
        path.addArc(withCenter: topRightArc, radius: cornerRad, startAngle: -.pi * 0.5, endAngle: 0.0, clockwise: true)
        
        // botRightArc
        path.addArc(withCenter: botRightArc, radius: cornerRad, startAngle: 0.0, endAngle: .pi * 0.5, clockwise: true)
        
        // botLeftArc
        path.addArc(withCenter: botLeftArc, radius: cornerRad, startAngle: .pi * 0.5, endAngle: .pi * 1.0, clockwise: true)
        
        path.close()
        
        return path.cgPath
    }
    
    func setupAddNewFlowerButton() {
        
        var addNewFlowerButtonFrame = addNewFlowerButton.frame
        addNewFlowerButtonFrame.origin.y = view.bounds.height - addNewFlowerButtonFrame.height - 40
        addNewFlowerButtonFrame.origin.x = view.bounds.width/2 - addNewFlowerButtonFrame.size.width/2
        addNewFlowerButton.frame = addNewFlowerButtonFrame
        
        addNewFlowerButton.backgroundColor = UIColor(hexString: "#CFD9CE")
        addNewFlowerButton.layer.cornerRadius = addNewFlowerButtonFrame.height/2
        view.addSubview(addNewFlowerButton)
        
        addNewFlowerButton.setImage(UIImage(named: "addNewFlower"), for: .normal)
        addNewFlowerButton.contentMode = .scaleAspectFill
        addNewFlowerButton.addTarget(self, action: #selector(addNewFlowerButtonAction(sender:)), for: .touchUpInside)
        
        view.layoutIfNeeded()
    }
    
    @objc private func addNewFlowerButtonAction(sender: UIButton) {
        selectedIndex = 1
    }
    
    func hideTabBar() {
        self.tabBar.isHidden = true
        self.addNewFlowerButton.isHidden = true
    }
    
    func showTabBar() {
        self.tabBar.isHidden = false
        self.addNewFlowerButton.isHidden = false
    }
}
