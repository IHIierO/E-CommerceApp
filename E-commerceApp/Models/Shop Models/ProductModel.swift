//
//  ProductModel.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 18.10.2022.
//

import UIKit

struct Product: Identifiable{

    var id = UUID()
    var productName: String = ""
    var productDescription: String?
    var productCategory: String = ""
    var productSecondCategory: String = ""
    var count: Int = 1
    var price: Int = 0
    var discount: Int?
    var productImage: [String] = []
    var rating: Int = 0
    var volume: String?
    var newest: Bool = false
    
}

class Products {
    static var products: [Product] = [
        .init(productName: "Гель для рук \"8018\" (60мл)",
             productDescription: "Антибактериальный гель для рук «8018». Используется для дезинфекции кожи рук. Убивает 99,9% болезнетворных бактерий, грибов и вирусов.",
             productCategory: "for hands",
             productSecondCategory: "gel",
             price: 720,
             productImage: ["gel_for_hands_8018_60ml_1", "gel_for_hands_8018_60ml_2", "gel_for_hands_8018_60ml_3", "gel_for_hands_8018_60ml_4"],
             volume: "60ml"),
        .init(productName: "Гель для рук \"8018\" (300мл)",
              productDescription: """
                                    Гель для рук с алоэ вера и витамином Е. Гель для обработки рук на основе этилового спирта, который убивает 99,9% болезнетворных бактерий, грибков и вирусов.
                                    
                                    Способ применения: выдавите небольшое количество геля на ладонь и тщательно разотрите руки до полного высыхания.
                                    
                                    Внимание! Легко воспламеняется, беречь от огня и чрезмерного нагревания. Только для наружного применения. В случае попадания в глаза немедленно промыть водой, при необходимости обратиться к врачу.
                                    
                                    Хранить в сухом, защищенном от света и недоступном для детей месте при температуре от -5С до +30С.
                                    
                                    Ingredients (INCI): Ethyl alcohol 66,2% vol., Aqua, Glycerin, Propylene Glycol, Acrylates/C10-30 Alkyl Acrylate Crosspolymer, Triethanolamine (TEA), Perfume, Тocopherol, Aloe barbadensis (aloe vera) leaf gel, Linallol, Citronellol, Geraniol, Lilial, Alpha-Isomethyl ionnone, Eugenol, Hexyl Cinnamaldehyde, Amyl Cinnamaldehyde, Benzyl Salicylate, Coumarin, D-Limonene, Citral, Benzyl Alcohol, Amyl Cinnamyl Alcohol, Benzyl Benzoate, Cinnamyl Alcohol, Isoeugenol.
                                    
                                    Срок годности: 3 года
                                    """,
              productCategory: "for hands",
              productSecondCategory: "gel",
              price: 2650,
              discount: 10,
              productImage: ["gel_for_hands_8018_300ml_1", "gel_for_hands_8018_300ml_2", "gel_for_hands_8018_300ml_3"],
              volume: "300ml")
    ]
    
    private init(){
        
    }
}
