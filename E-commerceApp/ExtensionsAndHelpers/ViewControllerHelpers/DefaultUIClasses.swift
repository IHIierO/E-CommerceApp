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
        self.backgroundColor = .clear
        self.textColor = UIColor(hexString: "#324B3A")
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

class PaddingLabel: UILabel {

    var edgeInset: UIEdgeInsets = .zero

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: edgeInset.top, left: edgeInset.left, bottom: edgeInset.bottom, right: edgeInset.right)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + edgeInset.left + edgeInset.right, height: size.height + edgeInset.top + edgeInset.bottom)
    }
}

class BackButton {
    var vc: UIViewController
    
    func createBackButton(){
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        backButton.tintColor = UIColor(hexString: "#324B3A")
        vc.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
   init(vc: UIViewController){
        self.vc = vc
    }
}
