//
//  PersonModel.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 31.10.2022.
//

import UIKit

struct PersonModel: Identifiable {
    var id = UUID()
    var name: String = "Name"
    var password: String = "Password"
    var image: String = "Image"
    var favoriteProducts: [Product] = []
    var productsInCart: [Product] = []
    var recentlyViewedProducts: [Product] = []
    
}

class Persons {
    static var ksenia = PersonModel(name: "Ksenia Vorobeva", image: "topRated")
    
    private init(){
        
    }
}



