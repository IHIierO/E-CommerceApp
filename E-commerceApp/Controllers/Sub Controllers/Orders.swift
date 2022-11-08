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
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension Orders: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Persons.ksenia.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.reuseId, for: indexPath) as! OrderCell
        cell.config(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 5
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
