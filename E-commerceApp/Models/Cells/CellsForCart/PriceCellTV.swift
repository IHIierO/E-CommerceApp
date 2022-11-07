//
//  PriceCell2.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 07.11.2022.
//

import UIKit

class PriceCellTV: UITableViewCell {
    
    static var reuseId: String = "PriceCell"
    
    let inAllName: UILabel = {
       let label = UILabel()
        label.text = "Итого"
        label.backgroundColor = .green
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let inAllNameData = [
    "Товаров в заказе",
    "Товары на сумму",
    "Скидка",
    "Итого",
    ]
    let inAllSum: UILabel = {
       let label = UILabel()
        label.text = "236"
        label.backgroundColor = .yellow
        label.textAlignment = .right
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        inAllName.text = "\(inAllNameData[indexPath.row])"
    }
    func setConstraints(){
        self.addSubview(inAllName)
        NSLayoutConstraint.activate([
            inAllName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            inAllName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            inAllName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/3)
        ])
        self.addSubview(inAllSum)
        NSLayoutConstraint.activate([
            inAllSum.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            inAllSum.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            inAllSum.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3)
        ])
    }

}
