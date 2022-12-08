//
//  Header.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 13.10.2022.
//

import UIKit

class Header: UICollectionReusableView {
   
    let headerLabel: UILabel = {
       let headerLabel = UILabel()
        headerLabel.textAlignment = .left
        headerLabel.textColor = UIColor(hexString: "#324B3A")
        headerLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        return headerLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: setConstraints
    
    private func setConstraints(){
        
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}

