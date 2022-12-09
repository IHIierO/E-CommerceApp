//
//  ResultsTableViewController.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 16.11.2022.
//

import UIKit

class ResultsTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    let array = ["Крем", "Гель", "Мыло", "Скраб", "Масло", "Кондиционер", "Маска", "Сыворотка", "Шампунь", "Для лица","Для тела","Для рук","Для волос","Для дома","Наборы", "Крем для рук", "Крем для лица"]
    var arrayFilter = [String]()
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        view.backgroundColor = UIColor(hexString: "#FDFAF3")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFilter.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        cell.textLabel?.text = arrayFilter[indexPath.row]
        cell.backgroundColor = UIColor(hexString: "#FDFAF3")
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        arrayFilter.removeAll()

        if let text = searchController.searchBar.text {
            
            if text.count > 2 {
                for string in array {
                    if string.lowercased().contains(text.lowercased()) {
                        arrayFilter.append(string)
                    }
                }
                for string in Products.products {
                    if string.productName.lowercased().contains(text.lowercased()) {
                        arrayFilter.append(string.productName)
                    }
                }
            }
        }
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        arrayFilter.removeAll()

        if let text = searchBar.text {
            
            if text.count > 2 {
                for string in array {
                    if string.contains(text.lowercased()) {
                        arrayFilter.append(string)
                    }
                }
                for string in Products.products {
                    if string.productName.lowercased().contains(text.lowercased()) {
                        arrayFilter.append(string.productName)
                    }
                }
            }
        }
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        arrayFilter.removeAll()
        tableView.reloadData()
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        arrayFilter.removeAll()
        tableView.reloadData()
        return true
    }
    
}
