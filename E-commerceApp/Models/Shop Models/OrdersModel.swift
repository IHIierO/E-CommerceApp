//
//  OrdersModel.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 08.11.2022.
//

import UIKit

struct OrdersModel: Identifiable{
    var id = UUID()
    var deliveryStatus: Bool
    var deliveryDate: Date
    var deliveryTime: String
    var recipientName: String
    var recipientNumber: String
    var deliveryMethod: String
    var deliveryAdress: String
    var paymentMethod: String
    var inAllSumData: [String]
    var productsInOrder: [Product]
    
}
