//
//  SearchAndListMenuCell.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 17.10.2022.
//

import UIKit

class SearchAndListMenuCell: UITableViewCell {
    
    let container: UIView = {
       let container = UIView()
        container.layer.cornerRadius = 8
        container.clipsToBounds = true
        container.layer.shadowRadius = 3
        container.layer.shadowOpacity = 0.8
        container.layer.shadowOffset = .zero
        container.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        container.layer.masksToBounds = false
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let menuLabel: PaddingLabel = {
       let label = PaddingLabel()
        label.backgroundColor = UIColor(hexString: "#FDFAF3")
        label.textColor = UIColor(hexString: "#324B3A")
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.edgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setConstraints()
    }
    
//    func configuration(indexPath: IndexPath){
//        menuLabel.text = "\(menuTextData[indexPath.row])"
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints(){
        self.addSubview(container)
        container.addSubview(menuLabel)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            menuLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            menuLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0),
            menuLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            menuLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
        ])
    }
}
