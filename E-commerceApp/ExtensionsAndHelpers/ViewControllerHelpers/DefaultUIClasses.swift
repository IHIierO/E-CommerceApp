//
//  DefaultUIClasses.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 10.11.2022.
//

import UIKit

class DefaultUITextField: UITextField {
    
    let placeholderText: String
    
    init(placeholderText: String){
        self.placeholderText = placeholderText
        super.init(frame: .zero)
        
        self.placeholder = placeholderText
        self.borderStyle = .roundedRect
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DefaultUIPickerView: UIPickerView{
    
    let tagNumber: Int
    
    init(tagNumber: Int){
        self.tagNumber = tagNumber
        super.init(frame: .zero)
        self.tag = tagNumber
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class DefaultUILabel: UILabel {
    
    let inputText: String
    let fontSize: CGFloat
    let fontWeight: UIFont.Weight
    
    init(inputText: String, fontSize: CGFloat, fontWeight: UIFont.Weight){
        self.inputText = inputText
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        super.init(frame: .zero)
        self.text = inputText
        self.font = .systemFont(ofSize: fontSize, weight: fontWeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
