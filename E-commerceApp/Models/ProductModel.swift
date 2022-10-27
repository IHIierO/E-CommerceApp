//
//  ProductModel.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 18.10.2022.
//

import UIKit

struct Product: Identifiable, Hashable {

    var id: String = UUID().uuidString
    var productName: String = ""
    var productDescription: String?
    var productCategory: String = ""
    var productSecondCategory: String = ""
    var count: Int = 0
    var price: Int = 0
    var discount: Int?
    var productImage: String
    var rating: Int = 0
    var favorite: Bool = false
    var shoppingCart: Bool = false
    var volume: String
    var newest: Bool = false
}

var products: [Product] = [
    .init(id: "Крем для лица Нивея",
          productName: "Крем для лица Нивея",
          productDescription: "С пептидами",
          productCategory: "для лица",
          productSecondCategory: "крем",
          count: 1,
          price: 98,
          discount: nil,
          productImage: "cream_for_face_1",
          rating: 0,
          shoppingCart: true,
         volume: "50ml",
         newest: true),
    .init(id: "Cream for hands 1",
          productName: "Cream for hands 1",
          productDescription: "with calogen",
          productCategory: "для рук",
          productSecondCategory: "крем",
          count: 1,
          price: 29,
          discount: 30,
          productImage: "cream_for_hands_1",
          rating: 10,
          shoppingCart: true,
          volume: "50ml",
          newest: true),
    .init(id: "Cream for hands 2",
          productName: "Cream for hands 2",
          productDescription: "with calogen",
          productCategory: "для рук",
          productSecondCategory: "крем",
          price: 40,
          discount: 0,
          productImage: "cream_for_hands_2",
          rating: 0,
         volume: "125ml",
          newest: true),
    .init(id: "Cream for hands 3",
          productName: "Cream for hands 3",
          productDescription: "with calogen",
          productCategory: "для рук",
          productSecondCategory: "крем",
          price: 45,
          discount: 10,
          productImage: "cream_for_hands_3",
          rating: 20,
         volume: "125ml",
          newest: true),
    .init(id: "Shampo 1",
          productName: "Shampo 1",
          productDescription: "with calogen",
          productCategory: "для волос",
          productSecondCategory: "шампунь",
          count: 1,
          price: 99,
          discount: 20,
          productImage: "shampo_1",
          rating: 23,
         favorite: true,
          shoppingCart: true,
         volume: "100ml"),
    .init(id: "Shampo 2",
          productName: "Shampo 2",
          productDescription: "with calogen",
          productCategory: "для волос",
          productSecondCategory: "шампунь",
          price: 89,
          discount: 10,
          productImage: "shampo_2",
          rating: 5,
         volume: "200ml",
         newest: true),
]
