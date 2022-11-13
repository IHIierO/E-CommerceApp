//
//  CurentOrder.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 13.11.2022.
//

import UIKit

class CurentOrder: UIViewController {
    
    let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let orderNumber = DefaultUILabel(inputText: "№", fontSize: 16, fontWeight: .regular)
    let deliveryStatus = DefaultUILabel(inputText: "Not delivery", fontSize: 16, fontWeight: .regular)
    let recipientDataHeader = DefaultUILabel(inputText: "Получатель", fontSize: 18, fontWeight: .bold)
    let recipientName = DefaultUILabel(inputText: "\(Persons.ksenia.name)", fontSize: 16, fontWeight: .regular)
    let recipientNumber = DefaultUILabel(inputText: "+7 914 694 8930", fontSize: 16, fontWeight: .regular)
    let recipientMail = DefaultUILabel(inputText: "Example@mail.ru", fontSize: 16, fontWeight: .regular)
    let deliveryDataHeader = DefaultUILabel(inputText: "О доставке", fontSize: 18, fontWeight: .bold)
    let deliveryMethod = DefaultUILabel(inputText: "Kur'er", fontSize: 16, fontWeight: .regular)
    let deliveryAdress = DefaultUILabel(inputText: "Nikolaya Rubcova 9", fontSize: 16, fontWeight: .regular)
    let deliveryDate = DefaultUILabel(inputText: "11.11.2022", fontSize: 16, fontWeight: .regular)
    let deliveryTime = DefaultUILabel(inputText: "11:00-13:00", fontSize: 16, fontWeight: .regular)
    let vStack: UIStackView = {
       let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.distribution = .equalSpacing
        vStack.alignment = .fill
        vStack.spacing = 20
        
        return vStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
    }
    
    private func setConstraints(){
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        scrollView.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            vStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        [orderNumber,deliveryStatus, recipientDataHeader, recipientName, recipientNumber, recipientMail, deliveryDataHeader, deliveryMethod, deliveryAdress, deliveryDate, deliveryTime].forEach {vStack.addArrangedSubview($0)}

    }
    
}

// MARK: - SwiftUI
import SwiftUI
struct CurentOrder_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let vc = CurentOrder()
            return vc
        }.edgesIgnoringSafeArea(.all)
    }
}
