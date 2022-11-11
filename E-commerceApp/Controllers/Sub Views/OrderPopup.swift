//
//  OrderPopup.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 08.11.2022.
//

import UIKit

class OrderPopup: UIView {
    
    var orderButtonTappedCallback: (()->())?
    
    let deliveryMethod = DefaultUITextField(placeholderText: "Укажите способ доставки", height: 60)
    let deliveryMethodPicker = DefaultUIPickerView(tagNumber: 1)
    let deliveryMethodData = ["Курьером", "Самовывоз"]
    let deliveryAdress = DefaultUITextField(placeholderText: "Укажите адрес доставки", height: 60)
    let deliveryDate = DefaultUITextField(placeholderText: "Укажите дату доставки", height: 60)
    let deliveryDatePicker: UIDatePicker = {
      let datePicker = UIDatePicker(frame: .zero)
      datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
      datePicker.timeZone = TimeZone.current
      return datePicker
    }()
    let deliveryTime = DefaultUITextField(placeholderText: "Укажите время доставки", height: 60)
    let deliveryTimePicker = DefaultUIPickerView(tagNumber: 2)
    let deliveryTimeData = ["10:00-12:00", "12:00-14:00", "14:00-16:00", "16:00-18:00", "18:00-20:00", "20:00-22:00"]
    let paymentMethod = DefaultUITextField(placeholderText: "Укажите способ оплаты", height: 60)
    let paymentMethodPicker = DefaultUIPickerView(tagNumber: 3)
    let paymentMethodData = ["Картой на сайте", "Картой курьеру", "Наличными"]
    let hStack: UIStackView = {
       let hStack = UIStackView()
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .vertical
        hStack.distribution = .fill
        hStack.alignment = .fill
        hStack.spacing = 20
        
        return hStack
    }()
    
    let blurEffect = UIBlurEffect(style: .dark)
    lazy var blurEffectView = UIVisualEffectView()
    
    private let container: UIView = {
       let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 24
        container.layer.shadowColor = UIColor(hexString: "#6A6F6A").cgColor
        container.layer.shadowOpacity = 0.8
        container.layer.shadowOffset = .zero
        container.layer.shadowRadius = 5
        
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    private let closeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
         var config = UIButton.Configuration.plain()
         config.imagePadding = 4
         config.image = UIImage(systemName: "xmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large))
         button.configuration = config
         button.tintColor = .black
         
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
    }()
    private let orderButton: UIButton = {
        let button = UIButton()
        button.configuration = .gray()
        button.configuration?.title = "Оформить"
        button.configuration?.baseForegroundColor = .black
        button.configuration?.cornerStyle = .capsule
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func animateOut(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        }) { (complite) in
            if complite {
                self.removeFromSuperview()
            }
        }
    }
    @objc private func animateIn(){
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
    @objc private func oderButtonTapped(){
        if deliveryMethod.text != nil &&
            deliveryAdress.text != nil &&
            deliveryDate.text != nil &&
            deliveryTime.text != nil &&
            paymentMethod.text != nil &&
            deliveryMethod.text != "" &&
            deliveryAdress.text != "" &&
            deliveryDate.text != "" &&
            deliveryTime.text != "" &&
            paymentMethod.text != ""
        {
            orderButtonTappedCallback?()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .clear
        self.frame = UIScreen.main.bounds
        
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        
        
        setConstraints()
        setupHStack()
//        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        closeButton.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
        orderButton.addTarget(self, action: #selector(oderButtonTapped), for: .touchUpInside)
//        animateIn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func config(indexPath: IndexPath) {
//        discountPercent.text = "Акция \(discountData[indexPath.row])%"
//        discountDescription.text = "Акция \(discountData[indexPath.row])% на всю косметику бренда Letual"
//    }
    
    private func setupHStack(){
        
        hStack.addArrangedSubview(deliveryMethod)
        hStack.addArrangedSubview(deliveryAdress)
        hStack.addArrangedSubview(deliveryDate)
        hStack.addArrangedSubview(deliveryTime)
        hStack.addArrangedSubview(paymentMethod)
        
        deliveryMethod.inputView = deliveryMethodPicker
        deliveryDate.inputView = deliveryDatePicker
        deliveryTime.inputView = deliveryTimePicker
        paymentMethod.inputView = paymentMethodPicker
        
        deliveryMethod.delegate = self
        deliveryDate.delegate = self
        deliveryTime.delegate = self
        paymentMethod.delegate = self
        
        deliveryMethodPicker.delegate = self
        deliveryMethodPicker.dataSource = self
        deliveryTimePicker.delegate = self
        deliveryTimePicker.dataSource = self
        paymentMethodPicker.delegate = self
        paymentMethodPicker.dataSource = self
        deliveryDatePicker.addTarget(self, action: #selector(selectDate(sender:)), for: .valueChanged)
        
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.pickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        deliveryMethod.inputAccessoryView = toolBar
        deliveryDate.inputAccessoryView = toolBar
        deliveryTime.inputAccessoryView = toolBar
        paymentMethod.inputAccessoryView = toolBar
    }
    
    @objc func pickerDone() {
        self.endEditing(true)
}
    
    @objc func selectDate(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
              dateFormatter.dateFormat = "dd MMM yyyy"
        deliveryDate.text = "Дата доставки: \(dateFormatter.string(from: sender.date))"
    }
    
    private func setConstraints(){
        self.addSubview(container)
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65)
        ])
        
        container.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        container.addSubview(orderButton)
        NSLayoutConstraint.activate([
            orderButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            orderButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            orderButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8),
            orderButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.1),
        ])
        
        container.addSubview(hStack)
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10),
//            hStack.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -10),
            hStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            hStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10)
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
        }
        if pickerView.tag == 2{
            deliveryTime.text = "Время доставки: \(deliveryTimeData[row])"
        }
        if pickerView.tag == 3{
            paymentMethod.text = "Вид оплаты: \(paymentMethodData[row])"
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == deliveryMethod{
            self.deliveryMethodPicker.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(deliveryMethodPicker, didSelectRow: 0, inComponent: 0)
        }
        if textField == deliveryDate{
            let dateFormatter = DateFormatter()
                  dateFormatter.dateFormat = "dd MMM yyyy"
            deliveryDate.text = "Дата доставки: \(dateFormatter.string(from: Date()))"
        }
        if textField == deliveryTime{
            self.deliveryTimePicker.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(deliveryTimePicker, didSelectRow: 0, inComponent: 0)
        }
        if textField == paymentMethod{
            self.paymentMethodPicker.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(paymentMethodPicker, didSelectRow: 0, inComponent: 0)
        }
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
