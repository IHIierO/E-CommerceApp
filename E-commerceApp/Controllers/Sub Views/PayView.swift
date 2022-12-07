//
//  PayView.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 05.12.2022.
//

import UIKit

class PayView: UIViewController {
    var buyButtonTappedCallback: (()->())?
    let buyButton = DefaultButton(buttonTitle: "Оплатить")
    let bankCardNumber = DefaultUITextField(placeholderText: "Введите номер карты")
    let bankCardDate = DefaultUITextField(placeholderText: "Введите дату")
    let bankCardCVV = DefaultUITextField(placeholderText: "Введите CVV код")
    var selectedCardType: String? {
        didSet{
            reformatAsCardNumber(textField: bankCardNumber)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPayView()
        setConstraints()
        
    }
    func setupPayView(){
        view.backgroundColor = UIColor(hexString: "#FDFAF3")
        [buyButton, bankCardNumber, bankCardDate, bankCardCVV].forEach({view.addSubview($0)})
        let doneButton = UIBarButtonItem.init(title: "Готово", style: .done, target: self, action: #selector(self.pickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        [bankCardNumber, bankCardDate, bankCardCVV].forEach({
            //$0.font = UIFont.systemFont(ofSize: 20)
            $0.textAlignment = .center
            $0.delegate = self
            $0.keyboardType = .asciiCapableNumberPad
            $0.inputAccessoryView = toolBar
        })
        buyButton.addTarget(self, action: #selector(oderButtonTapped), for: .touchUpInside)
        bankCardNumber.addTarget(self, action: #selector(reformatAsCardNumber(textField:)), for: .editingChanged)
        bankCardCVV.isSecureTextEntry = true
    }
    
    @objc func pickerDone() {
        view.endEditing(true)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            buyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            buyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            buyButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            bankCardNumber.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            bankCardNumber.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bankCardNumber.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            bankCardNumber.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            bankCardDate.topAnchor.constraint(equalTo: bankCardNumber.bottomAnchor, constant: 10),
            bankCardDate.leadingAnchor.constraint(equalTo: bankCardNumber.leadingAnchor),
            bankCardDate.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            bankCardDate.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            bankCardCVV.topAnchor.constraint(equalTo: bankCardNumber.bottomAnchor, constant: 10),
            bankCardCVV.trailingAnchor.constraint(equalTo: bankCardNumber.trailingAnchor),
            bankCardCVV.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            bankCardCVV.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
        ])
    }
    
    @objc private func oderButtonTapped(){
        if bankCardNumber.text != "" && bankCardDate.text != "" && bankCardCVV.text != ""{
            buyButtonTappedCallback?()
        }else{
            ViewControllersHelper.chekingBuyButtonTapped(bankCardNumber: bankCardNumber, bankCardDate: bankCardDate, bankCardCVV: bankCardCVV)
        }
    }
    
    @objc func reformatAsCardNumber(textField:UITextField){
        let formatter = CreditCardFormatter()
        var isAmex = false
        if selectedCardType == "AMEX" {
          isAmex = true
          }
        formatter.formatToCreditCardNumber(isAmex: isAmex, textField: textField, withPreviousTextContent: textField.text, andPreviousCursorPosition: textField.selectedTextRange)
      }
}

extension PayView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == bankCardCVV{
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 3
        }
        if textField == bankCardDate{
            let textLength = bankCardDate.text
            let newLength = textLength!.count + string.count - range.length
            return newLength <= 6
        }
        return true
    }
    #warning("Доделать текстфилд с датой, что бы подставлялся слэш после месяца")
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == bankCardDate{
            if var text = textField.text{
                if text.count > 2 {
                    if !text.contains("/"){
                        text.insert("/", at: (text.index(text.startIndex, offsetBy: 2)))
                        print("\(text)")
                        textField.text = text
                    }
                }
            }
        }
    }
}

// MARK: - SwiftUI
import SwiftUI
struct PayView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let vc = PayView()
            return vc
        }.edgesIgnoringSafeArea(.all)
            
    }
}
