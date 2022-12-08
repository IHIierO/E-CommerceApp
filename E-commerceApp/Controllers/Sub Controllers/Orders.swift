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
        navigationItem.title = "Заказы"
        BackButton(vc: self).createBackButton()
        setupTableView()
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.backgroundColor = UIColor(hexString: "#FDFAF3")
        
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
            content.textProperties.color = UIColor(hexString: "#324B3A")
            content.textProperties.alignment = .center
            content.textProperties.font = .systemFont(ofSize: 40)
            defaultCell.contentConfiguration = content
            defaultCell.backgroundColor = .clear
            return defaultCell
        }else{
            let orderCell = tableView.dequeueReusableCell(withIdentifier: OrderCell.reuseId, for: indexPath) as! OrderCell
            orderCell.config(indexPath: indexPath)
            return orderCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return view.bounds.height / 6 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ViewControllersHelper.pushToCurrentOrder(indexPath: indexPath, navigationController: self.navigationController!)
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
