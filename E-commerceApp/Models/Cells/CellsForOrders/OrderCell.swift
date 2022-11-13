//
//  OrderCell.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 08.11.2022.
//

import UIKit

class OrderCell: UITableViewCell {
    
    static var reuseId: String = "OrderCell"
    
    let orderNumber: UILabel = {
       let label = UILabel()
        label.text = "№"
        label.backgroundColor = .green
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let orderStatus: UILabel = {
       let label = UILabel()
        label.text = "Complite"
        label.backgroundColor = .green
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let orderAllSum: UILabel = {
       let label = UILabel()
        label.text = "K oplate 5 050$"
        label.backgroundColor = .green
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let hStack: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setConstraints()
            self.selectionStyle = .none
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    
    func config(indexPath: IndexPath){
        let number = "№ \(Persons.ksenia.orders[indexPath.row].id)"
        orderNumber.text = String(number.prefix(8))
        if Persons.ksenia.orders[indexPath.row].deliveryStatus == true {
            orderStatus.text = "Complite"
        }else{
            orderStatus.text = "Not complite"
        }
        orderAllSum.text = "K oplate \(Persons.ksenia.orders[indexPath.row].inAllSumData[3])"
        ViewControllersHelper.ordersProductsImage(hStack: hStack, indexPath: indexPath)
    }
        
    func setConstraints(){
        self.addSubview(orderNumber)
        NSLayoutConstraint.activate([
            orderNumber.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            orderNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            orderNumber.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            orderNumber.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])
        self.addSubview(orderStatus)
        NSLayoutConstraint.activate([
            orderStatus.topAnchor.constraint(equalTo: orderNumber.bottomAnchor, constant: 0),
            orderStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            orderStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            orderStatus.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])
        self.addSubview(orderAllSum)
        NSLayoutConstraint.activate([
            orderAllSum.topAnchor.constraint(equalTo: orderStatus.bottomAnchor, constant: 0),
            orderAllSum.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            orderAllSum.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            orderAllSum.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])
        self.addSubview(hStack)
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: orderAllSum.bottomAnchor, constant: 0),
            hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            hStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}

