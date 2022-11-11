//
//  DefaultUIClasses.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 10.11.2022.
//

import UIKit

class DefaultUITextField: UITextField {
    
    let placeholderText: String
    let height: CGFloat
    
    init(placeholderText: String, height: CGFloat){
        self.placeholderText = placeholderText
        self.height = height
        super.init(frame: .zero)
        
        self.placeholder = placeholderText
        self.borderStyle = .roundedRect
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
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
