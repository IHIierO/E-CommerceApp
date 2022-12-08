//
//  ViewControllersHelper.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 21.10.2022.
//

import UIKit

class ViewControllersHelper{
    //MARK: - pushToDiscount
    static func pushToDiscount (indexPath: IndexPath, view: UIView, discontPircent: Int, navigationController: UINavigationController?) {
        
        let discountsPercents = [10,20,30,50]
        let discountsPopup = DiscountsPopup()
        discountsPopup.config(indexPath: indexPath)
        view.addSubview(discountsPopup)
        discountsPopup.moreInfoButtonTappedCallback = {
            () in
            discountsPopup.animationHelpers.animateOut()
            let discounts = ProductsViewController()
            let curentDiscount = Products.products.filter({$0.discount == discountsPercents[indexPath.row]})
            var filterNames: [String] = ["Все"]
            for filterForProducts in curentDiscount {
                if !filterNames.contains(filterForProducts.productCategory){
                    filterNames.append(filterForProducts.productCategory)
                }
            }
            let filters = Filter(id: "0", names: filterNames)
            discounts.curentProducts = curentDiscount
            discounts.filters = filters
            navigationController?.pushViewController(discounts, animated: true)
        }
    }
    //MARK: - pushToProductsViewController
    static func pushToProductsViewController(indexPath: IndexPath, category: String, menuTextData: [String], navigationController: UINavigationController?, filters: Filter?, tableView: UITableView, resultsTableViewController: ResultsTableViewController) {
        
        if tableView == resultsTableViewController.tableView {
            let productCategory = ["Для лица","Для тела","Для рук","Для волос","Для дома","Наборы"]
            let productSecondCategory = ["Крем", "Гель", "Мыло", "Масло", "Скраб"]
            if productCategory.contains(resultsTableViewController.arrayFilter[indexPath.row]){
                let curentCategory = Products.products.filter({$0.productCategory == resultsTableViewController.arrayFilter[indexPath.row]})
                var filterNames: [String] = ["Все"]
                for filterForProducts in curentCategory {
                    if !filterNames.contains(filterForProducts.productSecondCategory){
                        filterNames.append(filterForProducts.productSecondCategory)
                    }
                }
                let filters = Filter(id: "0", names: filterNames)
                let productsViewController = ProductsViewController()
                productsViewController.title = "\(resultsTableViewController.arrayFilter[indexPath.row])"
                productsViewController.curentProducts = curentCategory
                productsViewController.filters = filters
                navigationController?.pushViewController(productsViewController, animated: true)
            }
            if productSecondCategory.contains(resultsTableViewController.arrayFilter[indexPath.row]){
                let curentSecondCategory = Products.products.filter({$0.productSecondCategory == resultsTableViewController.arrayFilter[indexPath.row]})
                var filterNames: [String] = ["Все"]
                for filterForProducts in curentSecondCategory {
                    if !filterNames.contains(filterForProducts.productCategory){
                        filterNames.append(filterForProducts.productCategory)
                    }
                }
                let filters = Filter(names: filterNames)
                let productsViewController = ProductsViewController()
                productsViewController.title = "\(resultsTableViewController.arrayFilter[indexPath.row])"
                productsViewController.curentProducts = curentSecondCategory
                productsViewController.filters = filters
                navigationController?.pushViewController(productsViewController, animated: true)
            }
            
            if Products.products.contains(where: {$0.productName == resultsTableViewController.arrayFilter[indexPath.row]}){
                let products11 = Products.products.filter({$0.productName == resultsTableViewController.arrayFilter[indexPath.row]})
                self.pushToProductCard(navigationController: navigationController, products: products11, indexPath: [0,0])
            }
        } else {
            let curentCategory = Products.products.filter({$0.productCategory == menuTextData[indexPath.row]})
            var filterNames: [String] = ["Все"]
            for filterForProducts in curentCategory {
                if !filterNames.contains(filterForProducts.productSecondCategory){
                    filterNames.append(filterForProducts.productSecondCategory)
                }
            }
            let filters = Filter(names: filterNames)
            let productsViewController = ProductsViewController()
            productsViewController.title = "\(menuTextData[indexPath.row])"
            productsViewController.curentProducts = curentCategory
            productsViewController.filters = filters
            navigationController?.pushViewController(productsViewController, animated: true)
        }
    }
    //MARK: - didSelectCurentFilter
    static func didSelectCurentFilter(filters: Filter, indexPath: IndexPath, collectionViewManageData: ProductsCollectionViewManageData, collectionView: UICollectionView, view: UIView, tabBarController: UITabBarController, curentProducts: [Product], vc: ProductsViewController) {
        
        if filters.names[indexPath.row] == "Все"{
            collectionViewManageData.setupDataSource(collectionView: collectionView, view: view, tabBarColtroller: tabBarController, curentProducts: curentProducts, filters: filters)
            collectionViewManageData.reloadData(curentProducts: curentProducts, filters: filters)
            vc.filteredProducts = curentProducts
        }
        
        let filterForCategory = ["Для лица", "Для тела", "Для рук", "Для волос", "Для дома", "Наборы"]
        let filterForSecondCategory = ["Крем", "Гель", "Мыло", "Масло", "Скраб"]
        
        if filterForSecondCategory.contains(filters.names[indexPath.row]){
            
            let curentCategory = curentProducts.filter({$0.productSecondCategory == filters.names[indexPath.row]})
                collectionViewManageData.setupDataSource(collectionView: collectionView, view: view, tabBarColtroller: tabBarController, curentProducts: curentCategory, filters: filters)
                collectionViewManageData.reloadData(curentProducts: curentCategory, filters: filters)
                vc.filteredProducts = curentCategory
            
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            guard let cell = collectionView.cellForItem(at: indexPath) as? ProductsMenuCell else { return }
            cell.isSelected = true
            cell.menuLabel.textColor = UIColor(hexString: "#FDFAF3")
            cell.backgroundColor = UIColor(hexString: "#324B3A")
        }
        
        if filterForCategory.contains(filters.names[indexPath.row]){
            let curentCategory = curentProducts.filter({$0.productCategory == filters.names[indexPath.row]})
                collectionViewManageData.setupDataSource(collectionView: collectionView, view: view, tabBarColtroller: tabBarController, curentProducts: curentCategory, filters: filters)
                collectionViewManageData.reloadData(curentProducts: curentCategory, filters: filters)
                vc.filteredProducts = curentCategory
                let cell = collectionView.cellForItem(at: indexPath) as! ProductsMenuCell
                cell.isSelected = true
            cell.menuLabel.textColor = UIColor(hexString: "#FDFAF3")
            cell.backgroundColor = UIColor(hexString: "#324B3A")
        }
    }
    //MARK: - pushToProductCard
    static func pushToProductCard(navigationController: UINavigationController?, products: [Product], indexPath: IndexPath){
        
        if Persons.ksenia.recentlyViewedProducts.count < 5 {
            if !Persons.ksenia.recentlyViewedProducts.contains(where: { product in
                product.id == products[indexPath.row].id
            }){
                Persons.ksenia.recentlyViewedProducts.append(products[indexPath.row])
            }
        }else{
            if !Persons.ksenia.recentlyViewedProducts.contains(where: { product in
                product.id == products[indexPath.row].id
            }){
                Persons.ksenia.recentlyViewedProducts.append(products[indexPath.row])
                Persons.ksenia.recentlyViewedProducts.removeFirst()
            }
        }
        
        let productCard = ProductCard()
        productCard.products = products
        productCard.indexPath = indexPath
        productCard.productName.text = "\(products[indexPath.row].productName)"
        productCard.productDiscription.text = "\(products[indexPath.row].productDescription!)"
        
        if products[indexPath.row].discount != nil {
            let discontPrice = (products[indexPath.row].price * (100 - (products[indexPath.row].discount ?? 100))/100)
            let discontPriceLabel = "\(discontPrice) \(products[indexPath.row].price) ₽"
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: discontPriceLabel)
            attributedString.createStringtToStrike(stringtToStrike: "\(products[indexPath.row].price)", size: 14)
            attributedString.createStringtToColor(stringtToColor: "\(discontPrice)", color: .red)
            attributedString.createStringtToColor(stringtToColor: "₽", color: UIColor(hexString: "#324B3A"))
            productCard.productPrice.attributedText = attributedString
        }else{
            productCard.productPrice.text = "\(products[indexPath.row].price) ₽"
        }
        navigationController?.pushViewController(productCard, animated: true)
    }
    //MARK: - pushToCurrentOrder
    static func pushToCurrentOrder(indexPath: IndexPath, navigationController: UINavigationController){
        let curentOrder = CurentOrder()
        let number = "№ \(Persons.ksenia.orders[indexPath.row].id)"
        curentOrder.orderNumber.text = String(number.prefix(8))
        if Persons.ksenia.orders[indexPath.row].deliveryStatus == false {
            curentOrder.deliveryStatus.text = "Заказ выполяется"
        }else{
            curentOrder.deliveryStatus.text = "Заказ выполнен"
        }
        curentOrder.recipientName.text = "\(Persons.ksenia.name)"
        curentOrder.deliveryMethod.text = "\(Persons.ksenia.orders[indexPath.row].deliveryMethod)"
        curentOrder.deliveryAdress.text = "\(Persons.ksenia.orders[indexPath.row].deliveryAdress)"
        curentOrder.deliveryDate.text = "\(Persons.ksenia.orders[indexPath.row].deliveryDate)"
        curentOrder.deliveryTime.text = "\(Persons.ksenia.orders[indexPath.row].deliveryTime)"
        if Persons.ksenia.orders[indexPath.row].paymentMethod == "Вид оплаты: Картой на сайте" {
            curentOrder.orderAllSum.text = "Оплачено \(Persons.ksenia.orders[indexPath.row].inAllSumData[3])"
        }else{
            curentOrder.orderAllSum.text = "К оплате \(Persons.ksenia.orders[indexPath.row].inAllSumData[3])"
        }
        navigationController.pushViewController(curentOrder, animated: true)
    }
    //MARK: - addToFavorite
    static func addToFavorite(products: [Product], indexPath: IndexPath) {
        
        if !Persons.ksenia.favoriteProducts.contains(where: { product in
            product.id == products[indexPath.row].id
        }){
            Persons.ksenia.favoriteProducts.append(products[indexPath.row])
        }else{
            if let index = Persons.ksenia.favoriteProducts.firstIndex(where: { product in
                product.id == products[indexPath.row].id
            }){
                Persons.ksenia.favoriteProducts.remove(at: index)
            }
        }
    }
    //MARK: - addToCart
    static func addToCart(products: [Product], indexPath: IndexPath, view: UIView, tabBarController: UITabBarController) {
        
        if !Persons.ksenia.productsInCart.contains(where: { product in
            product.id == products[indexPath.row].id
        }){
            Persons.ksenia.productsInCart.append(products[indexPath.row])
            let addToCartPopup = NotificationPopup()
            addToCartPopup.label.text = "Добавлен в корзину"
            view.addSubview(addToCartPopup)
            let tabBar = tabBarController as! TabBar
            tabBar.changeBageValue()
            
        }else{
            if let index = Persons.ksenia.productsInCart.firstIndex(where: { product in
                product.id == products[indexPath.row].id
            }){
                Persons.ksenia.productsInCart.remove(at: index)
            }
            let addToCartPopup = NotificationPopup()
            addToCartPopup.label.text = "Удален из корзины"
            view.addSubview(addToCartPopup)
            let tabBar = tabBarController as! TabBar
            tabBar.changeBageValue()
        }
    }
    //MARK: - chekingOderButtonTapped
    static func chekingOderButtonTapped(deliveryMethod: DefaultUITextField, deliveryAdress: DefaultUITextField, deliveryDate: DefaultUITextField, deliveryTime: DefaultUITextField, paymentMethod: DefaultUITextField) {
        if deliveryMethod.text == nil || deliveryMethod.text == "" {
            deliveryMethod.layer.borderWidth = 1
            deliveryMethod.layer.cornerRadius = 3
            deliveryMethod.layer.borderColor = UIColor.red.cgColor
        }else{
            deliveryMethod.borderStyle = .roundedRect
            deliveryMethod.layer.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.9).cgColor
        }
        if deliveryAdress.text == nil || deliveryAdress.text == "" {
            deliveryAdress.layer.borderWidth = 1
            deliveryAdress.layer.cornerRadius = 3
            deliveryAdress.layer.borderColor = UIColor.red.cgColor
        }else{
            deliveryAdress.borderStyle = .roundedRect
            deliveryAdress.layer.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.9).cgColor
        }
        if deliveryDate.text == nil || deliveryDate.text == "" {
            deliveryDate.layer.borderWidth = 1
            deliveryDate.layer.cornerRadius = 3
            deliveryDate.layer.borderColor = UIColor.red.cgColor
        }else{
            deliveryDate.borderStyle = .roundedRect
            deliveryDate.layer.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.9).cgColor
        }
        if deliveryTime.text == nil || deliveryTime.text == "" {
            deliveryTime.layer.borderWidth = 1
            deliveryTime.layer.cornerRadius = 3
            deliveryTime.layer.borderColor = UIColor.red.cgColor
        }else{
            deliveryTime.borderStyle = .roundedRect
            deliveryTime.layer.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.9).cgColor
        }
        if paymentMethod.text == nil || paymentMethod.text == "" {
            paymentMethod.layer.borderWidth = 1
            paymentMethod.layer.cornerRadius = 3
            paymentMethod.layer.borderColor = UIColor.red.cgColor
        }else{
            paymentMethod.borderStyle = .roundedRect
            paymentMethod.layer.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.9).cgColor
        }
    }
    //MARK: - chekingBuyButtonTapped
    static func chekingBuyButtonTapped(bankCardNumber: DefaultUITextField, bankCardDate: DefaultUITextField, bankCardCVV: DefaultUITextField){
        if bankCardNumber.text == nil || bankCardNumber.text == "" {
            bankCardNumber.layer.borderWidth = 1
            bankCardNumber.layer.cornerRadius = 3
            bankCardNumber.layer.borderColor = UIColor.red.cgColor
        }else{
            bankCardNumber.borderStyle = .roundedRect
            bankCardNumber.layer.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.9).cgColor
        }
        if bankCardDate.text == nil || bankCardDate.text == "" {
            bankCardDate.layer.borderWidth = 1
            bankCardDate.layer.cornerRadius = 3
            bankCardDate.layer.borderColor = UIColor.red.cgColor
        }else{
            bankCardDate.borderStyle = .roundedRect
            bankCardDate.layer.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.9).cgColor
        }
        if bankCardCVV.text == nil || bankCardCVV.text == "" {
            bankCardCVV.layer.borderWidth = 1
            bankCardCVV.layer.cornerRadius = 3
            bankCardCVV.layer.borderColor = UIColor.red.cgColor
        }else{
            bankCardCVV.borderStyle = .roundedRect
            bankCardCVV.layer.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.9).cgColor
        }
    }
    //MARK: - buyButtonTapLogic
    static func buyButtonTapLogic(inAllSumData: [String], vc: ShoppingCart){
        
        if Persons.ksenia.productsInCart.count > 0{
            let orderPopup = OrderPopup()
            orderPopup.orderButtonTappedCallback = { () in
                let newOrder = OrdersModel(deliveryStatus: false, deliveryDate: "\(orderPopup.deliveryDate.text!)", deliveryTime: "\(orderPopup.deliveryTime.text!)", recipientName: Persons.ksenia.name, recipientNumber: "+79146948930", deliveryMethod: "\(orderPopup.deliveryMethod.text!)", deliveryAdress: "\(orderPopup.deliveryAdress.text!)", paymentMethod: "\(orderPopup.paymentMethod.text!)", inAllSumData: inAllSumData, productsInOrder: Persons.ksenia.productsInCart)
                Persons.ksenia.orders.append(newOrder)
                
                if orderPopup.paymentMethod.text == "Вид оплаты: Картой на сайте" {
                    let payView = PayView()
                    if let presentationController = payView.presentationController as? UISheetPresentationController {
                        presentationController.prefersGrabberVisible = true
                        presentationController.detents = [.medium()]
                    }
                    vc.present(payView, animated: true)
                    payView.buyButtonTappedCallback = { () in
                       orderPopup.alpha = 0
                        orderPopup.animationHelpers.animateOut()
                        vc.dismiss(animated: true)
                        let addToOrder = NotificationPopup()
                        addToOrder.label.text = "Добавлено"
                        vc.view.addSubview(addToOrder)
                        Persons.ksenia.productsInCart.removeAll()
                        let tabBar = vc.tabBarController as! TabBar
                        tabBar.changeBageValue()
                        vc.tableView.reloadData()
                        vc.newData()
                    }
                }else{
                   orderPopup.alpha = 0
                    orderPopup.animationHelpers.animateOut()
                    vc.dismiss(animated: true)
                    let addToOrder = NotificationPopup()
                    addToOrder.label.text = "Добавлено"
                    vc.view.addSubview(addToOrder)
                    Persons.ksenia.productsInCart.removeAll()
                    let tabBar = vc.tabBarController as! TabBar
                    tabBar.changeBageValue()
                    vc.tableView.reloadData()
                    vc.newData()
                }
            }
            vc.view.addSubview(orderPopup)
            
            orderPopup.deliveryAdressTappedCallback = { () in
                
                let childViewController = PointsOfIssue()
                vc.addChild(childViewController)
                vc.view.addSubview(childViewController.view)
                childViewController.didMove(toParent: vc)
                childViewController.view.translatesAutoresizingMaskIntoConstraints = false
                childViewController.view.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor, constant: 0).isActive = true
                childViewController.view.heightAnchor.constraint(equalToConstant: 400).isActive = true
                childViewController.view.widthAnchor.constraint(equalTo: vc.view.widthAnchor).isActive = true
                childViewController.doneButtonTappedCallback = { () in
                    vc.children.forEach({ $0.willMove(toParent: nil); $0.view.removeFromSuperview(); $0.removeFromParent() })
                }
                childViewController.deliveryAdressTappedCallback = { () in
                    orderPopup.deliveryAdress.text = childViewController.saintPetersburg[childViewController.currentIndex.row]
                }
            }
        }
    }
}
