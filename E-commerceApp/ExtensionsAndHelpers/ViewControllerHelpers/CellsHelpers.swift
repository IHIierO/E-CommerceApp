//
//  CellsHelpers.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 28.11.2022.
//

import UIKit

class CellsHelpers {
    //MARK: - stepperHelper
    static func stepperHelper(cell: CartCell, indexPath: IndexPath, tableView: UITableView, vc: ShoppingCart){
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
    //MARK: - configurationCartCellWhenCartIsEmpty
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
    //MARK: - priceLabelText
    static func priceLabelText(indexPath: IndexPath, products: [Product], priceLabel: UILabel){
        if products[indexPath.row].discount != nil {
            let discontPrice = (products[indexPath.row].price * (100 - (products[indexPath.row].discount ?? 100))/100)
            let discontPriceLabel = "\(discontPrice) \(products[indexPath.row].price) ₽"
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: discontPriceLabel)
            attributedString.createStringtToStrike(stringtToStrike: "\(products[indexPath.row].price)", size: 14)
            attributedString.createStringtToColor(stringtToColor: "\(discontPrice)", color: .red)
            attributedString.createStringtToColor(stringtToColor: "₽", color: UIColor(hexString: "#324B3A"))
            priceLabel.attributedText = attributedString
        }else{
            priceLabel.text = "\(products[indexPath.row].price) ₽"
        }
    }
    //MARK: - buttonsImageConfiguration
    static func buttonsImageConfiguration(indexPath: IndexPath, products: [Product], favoriteButton: DefaultFavoriteButton, addToShoppingCard: DefaultAddToShoppingCard){
        if Persons.ksenia.favoriteProducts.contains(where: { product in
            product.id == products[indexPath.row].id
        }){
            favoriteButton.configuration?.image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large))
        }else{
            favoriteButton.configuration?.image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large))
        }
        
        if Persons.ksenia.productsInCart.contains(where: { product in
            product.id == products[indexPath.row].id
        }){
            addToShoppingCard.configuration?.image = UIImage(systemName: "cart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large))
        }else{
            addToShoppingCard.configuration?.image = UIImage(systemName: "cart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large))
        }
    }
}
