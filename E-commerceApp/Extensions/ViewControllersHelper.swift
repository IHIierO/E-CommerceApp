//
//  ViewControllersHelper.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 21.10.2022.
//

import UIKit

class ViewControllersHelper {
    
    static func pushToDiscount (indexPath: IndexPath, view: UIView, discontPircent: Int, navigationController: UINavigationController?) {
        let discountsPopup = DiscountsPopup()
        discountsPopup.config(indexPath: indexPath)
        view.addSubview(discountsPopup)
        discountsPopup.moreInfoButtonTappedCallback = {
            () in
            discountsPopup.animateOut()
            let discounts = Discounts()
            let curendDiscoun = products.filter({$0.discount == discontPircent})
            print("\(curendDiscoun)")
            discounts.discountLabel.text = curendDiscoun[0].productName
            discounts.discountData = discountsPopup.discountData
//                    discounts.config(indexPath: indexPath)
            navigationController?.pushViewController(discounts, animated: true)
        }
    }
    
    static func pushToProductsViewController(indexPath: IndexPath, category: String, menuTextData: [String], navigationController: UINavigationController?, filters: Filter) {
        let creamForHands = products.filter({$0.productCategory == category})
        let productsViewController = ProductsViewController()
        productsViewController.title = "\(menuTextData[indexPath.row])"
        productsViewController.curentProducts = creamForHands
        productsViewController.filters = filters
        navigationController?.pushViewController(productsViewController, animated: true)
    }
}
