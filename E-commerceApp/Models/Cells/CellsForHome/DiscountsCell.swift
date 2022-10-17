//
//  DiscountsCell.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//

import UIKit

class DiscountsCell: UICollectionViewCell, SelfConfiguringCell {
    
    
    static var reuseId: String = "DiscountsCell"
    
    let discontImage: UIImageView = {
       let discontImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
//        discontImage.image = UIImage(named: "discont")
        discontImage.contentMode = .scaleAspectFill
//        flowerImage.layer.cornerRadius = 15
//        flowerImage.clipsToBounds = true
        
        discontImage.translatesAutoresizingMaskIntoConstraints = false
        return discontImage
    }()
    
    private let discontImageDate = [
    "discont_10",
    "discont_20",
    "discont_30",
    "discont_50"
    ]
    
    func configure(with itemIdentifier: Int, indexPath: IndexPath) {
        discontImage.image = UIImage(named: "\(discontImageDate[indexPath.row])")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .purple
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(){
        self.addSubview(discontImage)
        NSLayoutConstraint.activate([
            discontImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            discontImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            discontImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            discontImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
}