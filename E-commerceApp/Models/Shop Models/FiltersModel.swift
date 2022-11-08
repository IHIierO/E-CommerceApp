//
//  FiltersModel.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 20.10.2022.
//

import UIKit

struct Filter: Identifiable, Hashable {

    var id: String = UUID().uuidString
    var names: [String]
    
}
