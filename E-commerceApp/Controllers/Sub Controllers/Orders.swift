//
//  Orders.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 08.11.2022.
//

import UIKit

class Orders: UIViewController {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Orders"
        setupTableView()
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OrderCell.self, forCellReuseIdentifier: OrderCell.reuseId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension Orders: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if Persons.ksenia.orders.isEmpty {
            return 1
        }else{
            return Persons.ksenia.orders.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if Persons.ksenia.orders.isEmpty {
            let defaultCell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
            var content = defaultCell.defaultContentConfiguration()
            content.text = "Нет заказов"
            content.textProperties.alignment = .center
            content.textProperties.font = .systemFont(ofSize: 40)
            defaultCell.contentConfiguration = content
            return defaultCell
        }else{
            let orderCell = tableView.dequeueReusableCell(withIdentifier: OrderCell.reuseId, for: indexPath) as! OrderCell
            orderCell.config(indexPath: indexPath)
            return orderCell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let curentOrder = CurentOrder()
        let number = "№ \(Persons.ksenia.orders[indexPath.row].id)"
        curentOrder.orderNumber.text = String(number.prefix(8))
        curentOrder.deliveryStatus.text = "\(Persons.ksenia.orders[indexPath.row].deliveryStatus)"
        curentOrder.recipientName.text = "\(Persons.ksenia.name)"
        curentOrder.deliveryMethod.text = "\(Persons.ksenia.orders[indexPath.row].deliveryMethod)"
        curentOrder.deliveryAdress.text = "\(Persons.ksenia.orders[indexPath.row].deliveryAdress)"
        curentOrder.deliveryDate.text = "\(Persons.ksenia.orders[indexPath.row].deliveryDate)"
        curentOrder.deliveryTime.text = "\(Persons.ksenia.orders[indexPath.row].deliveryTime)"
        navigationController?.pushViewController(curentOrder, animated: true)
    }
}


// MARK: - SwiftUI
import SwiftUI
struct Orders_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let vc = Orders()
            return vc
        }.edgesIgnoringSafeArea(.all)
    }
}
