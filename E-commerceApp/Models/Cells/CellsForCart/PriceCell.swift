//
//  PriceCell.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 24.10.2022.
//

import UIKit

class PriceCell: UICollectionViewCell {
    static var reuseId: String = "PriceCell"
    var productsToCart = products.filter({$0.shoppingCart == true})
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        self.backgroundColor = .brown
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(indexPath: IndexPath){
        inAllName.text = "\(inAllNameData[indexPath.row])"
//        inAllSum.text = "\(inAllSumData[indexPath.row])"
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
