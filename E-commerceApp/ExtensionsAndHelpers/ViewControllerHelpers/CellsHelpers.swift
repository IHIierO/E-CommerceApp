//
//  CellsHelpers.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 28.11.2022.
//

import UIKit

class CellsHelpers {
    
    static func stepperHelper(cell: CartCellTV, indexPath: IndexPath, tableView: UITableView, vc: ShoppingCartTV){
        cell.plusButtonCallback = {
            () in
            if Persons.ksenia.productsInCart[indexPath.row].count != 10 {
                Persons.ksenia.productsInCart[indexPath.row].count = Persons.ksenia.productsInCart[indexPath.row].count + 1
                vc.newData()
                cell.stepperLabel.text = "\(Persons.ksenia.productsInCart[indexPath.row].count)"
                tableView.reloadData()
            }else{
                Persons.ksenia.productsInCart[indexPath.row].count = Persons.ksenia.productsInCart[indexPath.row].count + 0
                cell.stepperLabel.text = "\(Persons.ksenia.productsInCart[indexPath.row].count)"
            }
        }
        cell.minusButtonCallback = {
            () in
            if Persons.ksenia.productsInCart[indexPath.row].count != 1 {
                Persons.ksenia.productsInCart[indexPath.row].count = Persons.ksenia.productsInCart[indexPath.row].count - 1
                vc.newData()
                cell.stepperLabel.text = "\(Persons.ksenia.productsInCart[indexPath.row].count)"
                tableView.reloadData()
            }else{
                Persons.ksenia.productsInCart[indexPath.row].count = Persons.ksenia.productsInCart[indexPath.row].count - 0
                cell.stepperLabel.text = "\(Persons.ksenia.productsInCart[indexPath.row].count)"
            }
        }
    }
    
    static func configurationCartCellWhenCartIsEmpty(cell: UITableViewCell){
        var content = cell.defaultContentConfiguration()
        content.text = "Нет товаров в корзине"
        content.textProperties.alignment = .center
        content.textProperties.font = .systemFont(ofSize: 28)
        content.textProperties.adjustsFontSizeToFitWidth = true
        content.secondaryText = "Пожалуйста выберети товары из каталога"
        content.secondaryTextProperties.alignment = .center
        content.secondaryTextProperties.font = .systemFont(ofSize: 18)
        content.secondaryTextProperties.adjustsFontSizeToFitWidth = true
        cell.contentConfiguration = content
        cell.backgroundColor = .clear
    }
}
