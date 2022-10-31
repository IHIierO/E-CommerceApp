//
//  PersonModel.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 31.10.2022.
//

import UIKit

struct PersonModel: Identifiable {
    var id = UUID()
    var name: String
    var password: String
    var image: String
    var products: [Product]?
}
