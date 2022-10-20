//
//  SelfConfiguringCell.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//

import Foundation
import UIKit

protocol SelfConfiguringCell{
    static var reuseId: String {get}
    func configure(with itemIdentifier: Int, indexPath: IndexPath, products: [Product])
}
