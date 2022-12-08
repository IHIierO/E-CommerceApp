//
//  DiscountsCell.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//

import UIKit

class DiscountsCell: UICollectionViewCell{
    
    static var reuseId: String = "DiscountsCell"
    
    let discontImage: UIImageView = {
       let discontImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        discontImage.image = UIImage(named: "sale")
        discontImage.contentMode = .scaleAspectFill
        discontImage.layer.cornerRadius = 8
        discontImage.clipsToBounds = true
        
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
       // discontImage.image = UIImage(named: "\(discontImageDate[indexPath.row])")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setConstraints()
    }
    
    private func setupCell(){
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        self.clipsToBounds = false
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
