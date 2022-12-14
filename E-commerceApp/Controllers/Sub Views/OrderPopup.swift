//
//  OrderPopup.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 08.11.2022.
//

import UIKit

class OrderPopup: UIView {
    
    var orderButtonTappedCallback: (()->())?
    var deliveryAdressTappedCallback: (()->())?
    
    var animationHelpers: AnimationHelpers!
    
    private let container = DefaultContainerView()
    private let closeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
         var config = UIButton.Configuration.plain()
         config.imagePadding = 4
         config.image = UIImage(systemName: "xmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large))
         button.configuration = config
         button.tintColor = UIColor(hexString: "#324B3A")
         
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
    }()
    private let orderButton = DefaultButton(buttonTitle: "Перейти к оплате")
    
    let deliveryMethod = DefaultUITextField(placeholderText: "Укажите способ доставки")
    let deliveryMethodPicker = DefaultUIPickerView(tagNumber: 1)
    let deliveryMethodData = ["Курьером", "Самовывоз"]
    var deliveryAdress = DefaultUITextField(placeholderText: "Укажите адрес доставки")
    let deliveryDate = DefaultUITextField(placeholderText: "Укажите дату доставки")
    let deliveryDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
       datePicker.preferredDatePickerStyle = .inline
        datePicker.locale = .autoupdatingCurrent
        datePicker.calendar = Calendar.current
        let today = Date()
        let startDay: Date = {
            let components = DateComponents(day: +7)
            return Calendar.current.date(byAdding: components, to: today)!
        }()
        
        datePicker.minimumDate = startDay
        
        return datePicker
    }()
    let deliveryTime = DefaultUITextField(placeholderText: "Укажите время доставки")
    let deliveryTimePicker = DefaultUIPickerView(tagNumber: 2)
    let deliveryTimeData = ["10:00-12:00", "12:00-14:00", "14:00-16:00", "16:00-18:00", "18:00-20:00", "20:00-22:00"]
    let paymentMethod = DefaultUITextField(placeholderText: "Укажите способ оплаты")
    let paymentMethodPicker = DefaultUIPickerView(tagNumber: 3)
    let paymentMethodData = ["Картой на сайте", "Картой курьеру", "Наличными"]
    let warningLabel: UILabel = {
       let label = UILabel()
        label.text = "Заполните все красные поля"
        label.textAlignment = .center
        label.textColor = .red
        label.layer.opacity = 0
        return label
    }()
    let vStack: UIStackView = {
       let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.distribution = .fillProportionally
        vStack.alignment = .fill
        vStack.spacing = 20
        
        return vStack
    }()
    
    let blurEffect = UIBlurEffect(style: .regular)
    lazy var blurEffectView = UIVisualEffectView()
    
    @objc private func oderButtonTapped(){
        if deliveryMethod.text != "" &&
            deliveryAdress.text != "" &&
            deliveryDate.text != "" &&
            deliveryTime.text != "" &&
            paymentMethod.text != ""
        {
            warningLabel.layer.opacity = 0
            orderButtonTappedCallback?()
        }else{
            ViewControllersHelper.chekingOderButtonTapped(deliveryMethod: deliveryMethod, deliveryAdress: deliveryAdress, deliveryDate: deliveryDate, deliveryTime: deliveryTime, paymentMethod: paymentMethod)
            warningLabel.layer.opacity = 1
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        setConstraints()
        setupVStack()
//        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        
        animationHelpers = AnimationHelpers(view: self, container: container)
        closeButton.addTarget(animationHelpers, action: #selector(animationHelpers.animateOut), for: .touchUpInside)
        orderButton.addTarget(self, action: #selector(oderButtonTapped), for: .touchUpInside)
        animationHelpers.animateIn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupVStack(){
        
        [deliveryMethod,deliveryAdress,deliveryDate,deliveryTime,paymentMethod,warningLabel].forEach {vStack.addArrangedSubview($0)}
        
        deliveryMethod.inputView = deliveryMethodPicker
        deliveryDate.inputView = deliveryDatePicker
        deliveryTime.inputView = deliveryTimePicker
        paymentMethod.inputView = paymentMethodPicker
        
        [deliveryMethod,deliveryAdress,deliveryDate,deliveryTime,paymentMethod].forEach {$0.delegate = self}
        
        [deliveryMethodPicker,deliveryTimePicker,paymentMethodPicker].forEach {
            $0.delegate = self
            $0.dataSource = self
        }
        deliveryDatePicker.addTarget(self, action: #selector(selectDate(sender:)), for: .valueChanged)
        
        let doneButton = UIBarButtonItem.init(title: "Готово", style: .done, target: self, action: #selector(self.pickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        [deliveryMethod,deliveryDate,deliveryTime,paymentMethod].forEach {$0.inputAccessoryView = toolBar}
    }
    
    @objc func pickerDone() {
        self.endEditing(true)
    }
    @objc func selectDate(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru")
              dateFormatter.dateFormat = "dd MMMM yyyy"
        deliveryDate.text = "Дата доставки: \(dateFormatter.string(from: sender.date))"
    }
    
    private func setConstraints(){
        self.addSubview(container)
        
        [closeButton, orderButton, vStack].forEach{
            container.addSubview($0)
        }
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),
            
            closeButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            
            orderButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            orderButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            orderButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8),
            orderButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.1),
            
            vStack.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10),
            vStack.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -10),
            vStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            vStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10)
        ])
    }
}
// MARK: - UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate
extension OrderPopup: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return deliveryMethodData.count
        }
        if pickerView.tag == 2{
            return deliveryTimeData.count
        }
        if pickerView.tag == 3{
            return paymentMethodData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return "\(deliveryMethodData[row])"
        }
        if pickerView.tag == 2{
            return "\(deliveryTimeData[row])"
        }
        if pickerView.tag == 3{
            return "\(paymentMethodData[row])"
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            deliveryMethod.text = "Способ доставки: \(deliveryMethodData[row])"
            if deliveryMethod.text == "Способ доставки: Самовывоз" {
                deliveryAdress.updatePlaceholder(newPlaceholderText: "Выберете пункт самовывоза")
            }else{
                deliveryAdress.text = nil
                deliveryAdress.updatePlaceholder(newPlaceholderText: "Укажите адрес доставки")
            }
        }
        if pickerView.tag == 2{
            deliveryTime.text = "Время доставки: \(deliveryTimeData[row])"
        }
        if pickerView.tag == 3{
            paymentMethod.text = "Вид оплаты: \(paymentMethodData[row])"
            if paymentMethod.text == "Вид оплаты: Картой на сайте"{
                orderButton.updateButtonTitle(newButtonTitle: "Перейти к оплате")
            }else{
                orderButton.updateButtonTitle(newButtonTitle: "Оформить")
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == deliveryMethod{
            self.deliveryMethodPicker.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(deliveryMethodPicker, didSelectRow: 0, inComponent: 0)
        }
        if textField == deliveryDate{
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru")
                  dateFormatter.dateFormat = "dd MMMM yyyy"
            deliveryDate.text = "Дата доставки: \(dateFormatter.string(from: deliveryDatePicker.date))"
        }
        if textField == deliveryTime{
            self.deliveryTimePicker.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(deliveryTimePicker, didSelectRow: 0, inComponent: 0)
        }
        if textField == paymentMethod{
            self.paymentMethodPicker.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(paymentMethodPicker, didSelectRow: 0, inComponent: 0)
        }
        if textField == deliveryAdress {
            if deliveryMethod.text == "Способ доставки: Самовывоз" {
                deliveryAdressTappedCallback?()
                self.endEditing(true)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        return self.endEditing(true)
       
        }
}

// MARK: - SwiftUI
import SwiftUI
struct OrderPopupPreviews: PreviewProvider {
    static var previews: some View {
        ViewPreview{
            let view = OrderPopup()
            return view
        }.ignoresSafeArea(.all)
    }
}
