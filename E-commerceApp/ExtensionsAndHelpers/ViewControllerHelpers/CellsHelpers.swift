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
        content.textProperties.color = UIColor(hexString: "#324B3A")
        content.secondaryText = "Пожалуйста выберети товары из каталога"
        content.secondaryTextProperties.alignment = .center
        content.secondaryTextProperties.font = .systemFont(ofSize: 18)
        content.secondaryTextProperties.adjustsFontSizeToFitWidth = true
        content.secondaryTextProperties.color = UIColor(hexString: "#324B3A")
        cell.contentConfiguration = content
        cell.backgroundColor = .clear
    }
    
    static func changeSwipeActionSize(){
        //  func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        //        if let swipeContainerView = tableView.subviews.first(where: { String(describing: type(of: $0)) == "_UITableViewCellSwipeContainerView" }) {
        //            if let swipeActionPullView = swipeContainerView.subviews.first, String(describing: type(of: swipeActionPullView)) == "UISwipeActionPullView" {
        //                swipeActionPullView.frame.size.height -= 16
        //                swipeActionPullView.frame.origin.y += 8
        //                swipeActionPullView.layer.cornerRadius = 8
        //                swipeActionPullView.clipsToBounds = true
        //                swipeActionPullView.layer.shadowRadius = 8
        //                swipeActionPullView.layer.shadowOpacity = 0.8
        //                swipeActionPullView.layer.shadowOffset = .zero
        //                swipeActionPullView.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        //                swipeActionPullView.layer.masksToBounds = false
        //                if let swipeActionStandardButton = swipeActionPullView.subviews.first, String(describing: type(of: swipeActionStandardButton)) == "UISwipeActionStandardButton" {
        //                    swipeActionStandardButton.layer.cornerRadius = 8
        //                    swipeActionStandardButton.clipsToBounds = true
        //                }
        //            }
        //        }
        //    }
    }
    
    //MARK: - ordersProductsImage
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
                imageView.image = UIImage(named: Persons.ksenia.orders[indexPath.row].productsInOrder[i].productImage[0])
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
                hStack.addArrangedSubview(imageView)
            }
            
            let label = UILabel()
            label.text = "+ \(Persons.ksenia.orders[indexPath.row].productsInOrder.count - 5)"
            label.backgroundColor = UIColor(hexString: "#324B3A")
            label.textColor = UIColor(hexString: "#FDFAF3")
            label.textAlignment = .center
            label.layer.cornerRadius = 2
            label.clipsToBounds = true
            label.translatesAutoresizingMaskIntoConstraints = false
            label.widthAnchor.constraint(equalToConstant: 40).isActive = true
            hStack.addArrangedSubview(label)
        }
    }
}
