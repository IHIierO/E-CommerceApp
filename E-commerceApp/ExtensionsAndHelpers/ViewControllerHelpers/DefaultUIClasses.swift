//
//  DefaultUIClasses.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 10.11.2022.
//

import UIKit

//MARK: - DefaultUITextField
class DefaultUITextField: UITextField {
    
    var placeholderText: String
    
    init(placeholderText: String){
        self.placeholderText = placeholderText
        super.init(frame: .zero)
        
        self.placeholder = placeholderText
        self.borderStyle = .roundedRect
        self.backgroundColor = .clear
        self.textColor = UIColor(hexString: "#324B3A")
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func updatePlaceholder(newPlaceholderText: String){
        self.placeholder = newPlaceholderText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - DefaultUIPickerView
class DefaultUIPickerView: UIPickerView{
    
    let tagNumber: Int
    
    init(tagNumber: Int){
        self.tagNumber = tagNumber
        super.init(frame: .zero)
        self.tag = tagNumber
        //self.inputViewController?.modalPresentationStyle = .popover
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK: - DefaultUILabel
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
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - PaddingLabel
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
//MARK: - BackButton
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
//MARK: - DefaultButton
class DefaultButton: UIButton {
    
    let buttonTitle: String
    
    init(buttonTitle: String){
        self.buttonTitle = buttonTitle
        super.init(frame: .zero)
        self.configuration = .filled()
        self.configuration?.title = buttonTitle
        self.configuration?.baseForegroundColor = UIColor(hexString: "#FDFAF3")
        self.configuration?.baseBackgroundColor = UIColor(hexString: "#324B3A")
        self.configuration?.titleAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func updateButtonTitle(newButtonTitle: String){
        self.configuration?.title = newButtonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - DefaultContainerView
class DefaultContainerView: UIView {
    
    init(){
        
        super.init(frame: .zero)
        self.backgroundColor = UIColor(hexString: "#FDFAF3")
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor(hexString: "#6A6F6A").cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - DefaultFavoriteButton
class DefaultFavoriteButton: UIButton{
    
    init(){
        super.init(frame: .zero)
        var config = UIButton.Configuration.plain()
        config.imagePadding = 4
        config.image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large))
        self.configuration = config
        self.tintColor = .red
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - DefaultFavoriteButton
class DefaultAddToShoppingCard: UIButton{
    
    init(){
        super.init(frame: .zero)
        var config = UIButton.Configuration.plain()
        config.imagePadding = 4
        config.image = UIImage(systemName: "cart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light))
        self.configuration = config
        self.tintColor = UIColor(hexString: "#324B3A")
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
