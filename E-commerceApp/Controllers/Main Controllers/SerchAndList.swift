//
//  SerchAndList.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//


import UIKit

class SerchAndList: UIViewController {
    
    private let searchBar = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()
    private var menuTextData:[String] = []
    private var search = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViewController()
        setupTableVIew()
    }

    private func setupViewController(){
        view.backgroundColor = .white
        title = "Categories"
        
        searchBar.searchResultsUpdater = self
        searchBar.searchBar.delegate = self
        navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupTableVIew(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        menuTextData = [
        "Косметика",
        "Банные принадлежности",
        "Бытовые принадлежности",
        "Еда",
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
extension SerchAndList: UISearchBarDelegate, UISearchResultsUpdating {
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
extension SerchAndList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if search{
            let searchText = searchBar.searchBar.text!
            let filterMenuTextData = menuTextData.filter({ $0.lowercased().contains(searchText.lowercased()) })
            return filterMenuTextData.count
        }else{
            return menuTextData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        if search {
            let searchText = searchBar.searchBar.text!
            let filterMenuTextData = menuTextData.filter({ $0.lowercased().contains(searchText.lowercased()) })
            cell.textLabel?.text = "\(filterMenuTextData[indexPath.row])"
        }else{
            cell.textLabel?.text = "\(menuTextData[indexPath.row])"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath{
        case [0,0]:
            let firstMenuController = FirstMenuController()
            navigationController?.pushViewController(firstMenuController, animated: true)
        case [0,1]:
            print("\(menuTextData[indexPath.row])")
        case [0,2]:
            print("\(menuTextData[indexPath.row])")
        case [0,3]:
            print("\(menuTextData[indexPath.row])")
        
        default:
            print("you dont select catigories")
        }
    }
}

// MARK: - SwiftUI
import SwiftUI
struct SerchAndListProvider: PreviewProvider{
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable{
        let serchAndList = TabBar()
        func makeUIViewController(context: Context) -> some TabBar {
            return serchAndList
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}

