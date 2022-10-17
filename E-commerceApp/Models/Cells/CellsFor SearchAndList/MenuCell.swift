//
//  MenuCell.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 17.10.2022.
//

import UIKit

class MenuCell: UITableViewCell {
    
    let menuLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
