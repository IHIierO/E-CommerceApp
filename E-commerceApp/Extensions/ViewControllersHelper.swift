//
//  ViewControllersHelper.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 21.10.2022.
//

import UIKit

class ViewControllersHelper{
    static func pushToDiscount (indexPath: IndexPath, view: UIView, discontPircent: Int, navigationController: UINavigationController?) {
        
        let discounts = [10,20,30,50]
        
        for discont in discounts{
            let index = discounts.firstIndex(of: discont)
            switch indexPath {
            case [0,Int(index!)]:
                let discountsPopup = DiscountsPopup()
                discountsPopup.config(indexPath: indexPath)
                view.addSubview(discountsPopup)
                discountsPopup.moreInfoButtonTappedCallback = {
                    () in
                    discountsPopup.animateOut()
                    let discounts = ProductsViewController()
                    let curentDiscount = Products.products.filter({$0.discount == discont})
                    var curentFilters = Filter(names: ["Delete filters"])
                    for product in curentDiscount {
                        let filters = Filter(names: ["для лица", "для тела", "для рук", "для волос", "для дома", "наборы"])
                        if filters.names.contains(product.productCategory) {
                            curentFilters.names.append(product.productCategory)
                        }
                    }
                    discounts.curentProducts = curentDiscount
                    discounts.filters = curentFilters
                    navigationController?.pushViewController(discounts, animated: true)
                }
            default:
                print("error1")
            }
        }
    }
    
    static func pushToProductsViewController(indexPath: IndexPath, category: String, menuTextData: [String], navigationController: UINavigationController?, filters: Filter) {
        let curentCategory = Products.products.filter({$0.productCategory == category})
        let productsViewController = ProductsViewController()
        productsViewController.title = "\(menuTextData[indexPath.row])"
        productsViewController.curentProducts = curentCategory
        productsViewController.filters = filters
        navigationController?.pushViewController(productsViewController, animated: true)
    }
    
    static func didSelectCurentFilter(filters: Filter, indexPath: IndexPath, collectionViewManageData: ProductsCollectionViewManageData, collectionView: UICollectionView, curentProducts: [Product], vc: ProductsViewController) {
        
        if filters.names.contains("Delete filters") {
            let index = filters.names.firstIndex(of: "Delete filters")
            switch indexPath {
            case [0,Int(index!)]:
                collectionViewManageData.setupDataSource(collectionView: collectionView, curentProducts: curentProducts, filters: filters)
                collectionViewManageData.reloadData(curentProducts: curentProducts, filters: filters)
                vc.filteredProducts = curentProducts
            default:
                print("error1")
            }
        }
        
        for name in filters.names {
            let filterForMl = ["50ml","100ml","125ml","200ml"]
            let filterForCategory = ["для лица", "для тела", "для рук", "для волос", "для дома", "наборы"]
            if filters.names.contains(name) && name != "Delete filters" && filterForMl.contains(name){
                let index = filters.names.firstIndex(of: name)
                switch indexPath {
                case [0,Int(index!)]:
                    let curentMl = curentProducts.filter({$0.volume == name})
                    collectionViewManageData.setupDataSource(collectionView: collectionView, curentProducts: curentMl, filters: filters)
                    collectionViewManageData.reloadData(curentProducts: curentMl, filters: filters)
                    vc.filteredProducts = curentMl
                default:
                    print("error2")
                }
            }else if filters.names.contains(name) && name != "Delete filters" && filterForCategory.contains(name){
                let index = filters.names.firstIndex(of: name)
                switch indexPath {
                case [0,Int(index!)]:
                    let curentCategory = curentProducts.filter({$0.productCategory == name})
                    collectionViewManageData.setupDataSource(collectionView: collectionView, curentProducts: curentCategory, filters: filters)
                    collectionViewManageData.reloadData(curentProducts: curentCategory, filters: filters)
                    vc.filteredProducts = curentCategory
                default:
                    print("error3")
                }
            }
        }
    }
    
    static func pushToProductCard(navigationController: UINavigationController?, products: [Product], indexPath: IndexPath){
        let productCard = ProductCard()
        
//        for image in 0...2 {
//            let imageToDisplay = UIImage(named: "cream_for_hands_\(image + 1)")
//            productCard.productImage.image = imageToDisplay
//            productCard.scrollView.addSubview(productCard.productImage)
//        }
        
//        productCard.productImage.image = UIImage(named: products[indexPath.row].productImage)
        productCard.product = products[indexPath.row]
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
        
        if !Persons.ksenia.favoriteProducts.contains(products[indexPath.row]){
            Persons.ksenia.favoriteProducts.append(products[indexPath.row])
        }else{
            if let index = Persons.ksenia.favoriteProducts.firstIndex(of: products[indexPath.row]){
                Persons.ksenia.favoriteProducts.remove(at: index)
            }
        }
    }
}
