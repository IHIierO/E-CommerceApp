//
//  ViewControllersHelper.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 21.10.2022.
//

import UIKit

class ViewControllersHelper{
    static func pushToDiscount (indexPath: IndexPath, view: UIView, discontPircent: Int, navigationController: UINavigationController?) {
        
        let discountsPercents = [10,20,30,50]
        let discountsPopup = DiscountsPopup()
        discountsPopup.config(indexPath: indexPath)
        view.addSubview(discountsPopup)
        discountsPopup.moreInfoButtonTappedCallback = {
            () in
            discountsPopup.animateOut()
            let discounts = ProductsViewController()
            let curentDiscount = Products.products.filter({$0.discount == discountsPercents[indexPath.row]})
            var filterNames: [String] = ["Delete filters"]
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
    
    static func pushToProductsViewController(indexPath: IndexPath, category: String, menuTextData: [String], navigationController: UINavigationController?, filters: Filter?, tableView: UITableView, resultsTableViewController: ResultsTableViewController) {
        
        if tableView == resultsTableViewController.tableView {
            let productCategory = ["для лица","для тела","для рук","для волос","для дома","наборы"]
            let productSecondCategory = ["крем", "гель", "мыло"]
            let name = "Крем для рук Дубовый мох, Амбра (50мл)"
            if productCategory.contains(resultsTableViewController.arrayFilter[indexPath.row]){
                let curentCategory = Products.products.filter({$0.productCategory == resultsTableViewController.arrayFilter[indexPath.row].lowercased()})
                var filterNames: [String] = ["Delete filters"]
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
                let curentSecondCategory = Products.products.filter({$0.productSecondCategory == resultsTableViewController.arrayFilter[indexPath.row].lowercased()})
                var filterNames: [String] = ["Delete filters"]
                for filterForProducts in curentSecondCategory {
                    if !filterNames.contains(filterForProducts.productCategory){
                        filterNames.append(filterForProducts.productCategory)
                    }
                }
                let filters = Filter(id: "0", names: filterNames)
                let productsViewController = ProductsViewController()
                productsViewController.title = "\(resultsTableViewController.arrayFilter[indexPath.row])"
                productsViewController.curentProducts = curentSecondCategory
                productsViewController.filters = filters
                navigationController?.pushViewController(productsViewController, animated: true)
            }
            if name == resultsTableViewController.arrayFilter[indexPath.row]{
#warning("добавить поиск по названию продуктов")
                let products11 = Products.products.filter({$0.productName == name})
                print("\(products11)")
                self.pushToProductCard(navigationController: navigationController, products: products11, indexPath: [0,0])
            }
        } else {
            let curentCategory = Products.products.filter({$0.productCategory == menuTextData[indexPath.row].lowercased()})
            var filterNames: [String] = ["Delete filters"]
            for filterForProducts in curentCategory {
                if !filterNames.contains(filterForProducts.productSecondCategory){
                    filterNames.append(filterForProducts.productSecondCategory)
                }
            }
            let filters = Filter(id: "0", names: filterNames)
            let productsViewController = ProductsViewController()
            productsViewController.title = "\(menuTextData[indexPath.row])"
            productsViewController.curentProducts = curentCategory
            productsViewController.filters = filters
            navigationController?.pushViewController(productsViewController, animated: true)
        }
        
        //MARK: - old pushToProductVC
        //        let curentCategory = Products.products.filter({$0.productCategory == category})
        //        let productsViewController = ProductsViewController()
        //        productsViewController.title = "\(menuTextData[indexPath.row])"
        //        productsViewController.curentProducts = curentCategory
        //        productsViewController.filters = filters
        //        navigationController?.pushViewController(productsViewController, animated: true)
    }
    
    static func didSelectCurentFilter(filters: Filter, indexPath: IndexPath, collectionViewManageData: ProductsCollectionViewManageData, collectionView: UICollectionView, view: UIView, tabBarController: UITabBarController, curentProducts: [Product], vc: ProductsViewController) {
        
        if filters.names[indexPath.row] == "Delete filters"{
            collectionViewManageData.setupDataSource(collectionView: collectionView, view: view, tabBarColtroller: tabBarController, curentProducts: curentProducts, filters: filters)
            collectionViewManageData.reloadData(curentProducts: curentProducts, filters: filters)
        }
        
        let filterForCategory = ["для лица", "для тела", "для рук", "для волос", "для дома", "наборы"]
        let filterForSecondCategory = ["гель", "мыло", "крем"]
        
        if filterForSecondCategory.contains(filters.names[indexPath.row]){
            let curentCategory = curentProducts.filter({$0.productSecondCategory == filters.names[indexPath.row]})
                collectionViewManageData.setupDataSource(collectionView: collectionView, view: view, tabBarColtroller: tabBarController, curentProducts: curentCategory, filters: filters)
                collectionViewManageData.reloadData(curentProducts: curentCategory, filters: filters)
                vc.filteredProducts = curentCategory
                let cell = collectionView.cellForItem(at: indexPath) as! ProductsMenuCell
                cell.isSelected = true
                cell.backgroundColor = .red
        }
        
        if filterForCategory.contains(filters.names[indexPath.row]){
            let curentCategory = curentProducts.filter({$0.productCategory == filters.names[indexPath.row]})
                collectionViewManageData.setupDataSource(collectionView: collectionView, view: view, tabBarColtroller: tabBarController, curentProducts: curentCategory, filters: filters)
                collectionViewManageData.reloadData(curentProducts: curentCategory, filters: filters)
                vc.filteredProducts = curentCategory
                let cell = collectionView.cellForItem(at: indexPath) as! ProductsMenuCell
                cell.isSelected = true
                cell.backgroundColor = .red
        }
    }
    
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
            }
        }
        
        let productCard = ProductCard()
        productCard.products = products
        productCard.indexPath = indexPath
        productCard.productName.text = "\(products[indexPath.row].productName)"
        productCard.productDiscription.text = "\(products[indexPath.row].productDescription ?? "")"
        
        if products[indexPath.row].discount != nil {
            let discontPrice = (products[indexPath.row].price * (100 - (products[indexPath.row].discount ?? 100))/100)
            productCard.productPrice.attributedText = "\(products[indexPath.row].price)  \(discontPrice) руб.".createAttributedString(stringtToStrike: "\(products[indexPath.row].price)")
        }else{
            productCard.productPrice.text = "\(products[indexPath.row].price) руб."
        }
        navigationController?.pushViewController(productCard, animated: true)
    }
    
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
    
    static func ordersProductsImage(hStack: UIStackView, indexPath: IndexPath){
        if Persons.ksenia.orders[indexPath.row].productsInOrder.count < 6 {
            for i in 0..<Persons.ksenia.orders[indexPath.row].productsInOrder.count {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imageView.image = UIImage(named: Persons.ksenia.orders[indexPath.row].productsInOrder[i].productImage[0])
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
                hStack.addArrangedSubview(imageView)
            }
        }else{
            for i in 0...4{
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imageView.image = UIImage(named: Persons.ksenia.orders[indexPath.row].productsInOrder[i].productImage[1])
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
                hStack.addArrangedSubview(imageView)
            }
            
            let label = UILabel()
            label.text = "+ \(Persons.ksenia.orders[indexPath.row].productsInOrder.count - 5)"
            label.backgroundColor = .lightGray
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.widthAnchor.constraint(equalToConstant: 40).isActive = true
            hStack.addArrangedSubview(label)
        }
    }
    
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
}
