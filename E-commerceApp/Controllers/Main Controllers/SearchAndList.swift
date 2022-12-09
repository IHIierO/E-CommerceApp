//
//  SearchAndList.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//


import UIKit

class SearchAndList: UIViewController, UISearchControllerDelegate {
    
    var resultsTableViewController = ResultsTableViewController(style: .grouped)
    
    var searchBar: UISearchController!
    private let tableView = UITableView()
    var menuTextData:[String] = []
    private var search = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableView()
    }

    private func setupViewController(){
        view.backgroundColor = UIColor(hexString: "#FDFAF3")
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        navigationItem.title = "Каталог"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#324B3A"), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28, weight: .semibold)]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#324B3A"), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)]
        //MARK: - setup searchBar
        searchBar = UISearchController(searchResultsController: resultsTableViewController)
        searchBar.searchBar.placeholder = "Поиск"
        searchBar.delegate = self
        searchBar.searchBar.delegate = resultsTableViewController
        searchBar.searchResultsUpdater = resultsTableViewController
        searchBar.obscuresBackgroundDuringPresentation = false
                definesPresentationContext = true
        resultsTableViewController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchCell")
        resultsTableViewController.tableView.delegate = self
        navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    private func setupTableView(){
        tableView.backgroundColor = UIColor(hexString: "#FDFAF3")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(SearchAndListMenuCell.self, forCellReuseIdentifier: "cell")
        menuTextData = [
        "Для лица",
        "Для тела",
        "Для рук",
        "Для волос",
        "Для дома",
        "Наборы"
        ]
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

//MARK: UISearchBarDelegate, UISearchResultsUpdating
extension SearchAndList: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty{
            search = true
        }else{
            search = false
        }
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search = false
        tableView.reloadData()
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension SearchAndList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return menuTextData.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchAndListMenuCell
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        cell.menuLabel.text = menuTextData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ViewControllersHelper.pushToProductsViewController(indexPath: indexPath, category: "", menuTextData: menuTextData, navigationController: self.navigationController, filters: nil, tableView: tableView, resultsTableViewController: resultsTableViewController)
    }
}

// MARK: - SwiftUI
import SwiftUI
struct SerchAndListProvider: PreviewProvider{
    static var previews: some View {
        UIViewControllerPreview {
            let vc = TabBar()
            return vc
        }.edgesIgnoringSafeArea(.all)
    }
}

