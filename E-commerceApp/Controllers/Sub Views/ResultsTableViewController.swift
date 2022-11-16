//
//  ResultsTableViewController.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 16.11.2022.
//

import UIKit

class ResultsTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var array = ["крем", "гель", "мыло","для лица","для тела","для рук","для волос","для дома","наборы"]
    var arrayFilter = [String]()
    var menuTextData = [
    "Для лица",
    "Для тела",
    "Для рук",
    "Для волос",
    "Для дома",
    "Наборы"
    ]

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
        return cell
    }

    func updateSearchResults(for searchController: UISearchController) {
        arrayFilter.removeAll()

        if let text = searchController.searchBar.text {
            for string in array {
                if string.contains(text.lowercased()) {
                    arrayFilter.append(string)
                }
            }
        }
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        arrayFilter.removeAll()

        if let text = searchBar.text {
            for string in array {
                if string.contains(text.lowercased()) {
                    arrayFilter.append(string)
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
