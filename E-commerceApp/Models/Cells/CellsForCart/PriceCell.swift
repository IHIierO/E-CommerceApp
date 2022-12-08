//
//  PriceCell.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 07.11.2022.
//

import UIKit

class PriceCell: UITableViewCell {
    
    static var reuseId: String = "PriceCell"
    
    let inAllName: UILabel = {
       let label = UILabel()
        label.text = "Итого"
        label.textColor = UIColor(hexString: "#324B3A")
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
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor(hexString: "#324B3A")
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        self.backgroundColor = .clear
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
            inAllName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            inAllName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            inAllName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/3)
        ])
        self.addSubview(inAllSum)
        NSLayoutConstraint.activate([
            inAllSum.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            inAllSum.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            inAllSum.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3)
        ])
    }

}
