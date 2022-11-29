//
//  Person.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//

import UIKit

class Person: UIViewController {
    
    let profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.masksToBounds = true
        profileImage.backgroundColor = .systemFill
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        return profileImage
    }()
    let profileNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .systemTeal
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let exitButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Выйти"
        button.configuration?.baseForegroundColor = UIColor(hexString: "#FDFAF3")
        button.configuration?.baseBackgroundColor = UIColor(hexString: "#324B3A")
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var profileMenuTextData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#FDFAF3")
        setupTableView()
        setConstraints()
        
        profileImage.image = UIImage(named: "\(Persons.ksenia.image)")
        profileNameLabel.text = Persons.ksenia.name
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.register(SearchAndListMenuCell.self, forCellReuseIdentifier: "cell")
        profileMenuTextData = [
        "Избранное",
        "Заказы",
        "Настройки профиля",
        "Справка",
        "Контакты",
        ]
    }

    private func setConstraints(){
        view.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            profileImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            profileImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
        ])
        view.addSubview(profileNameLabel)
        NSLayoutConstraint.activate([
            profileNameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 40),
            profileNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            profileNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            profileNameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        view.addSubview(exitButton)
        NSLayoutConstraint.activate([
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            exitButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: exitButton.topAnchor, constant: -40)
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension Person: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileMenuTextData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchAndListMenuCell
        //cell.backgroundColor = .red
       // var config = cell.defaultContentConfiguration()
        //config.text = profileMenuTextData[indexPath.row]
       // cell.contentConfiguration = config
        cell.menuLabel.text = profileMenuTextData[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath{
        case [0,0]:
            let favoriteProducts = ProductsViewController()
            favoriteProducts.curentProducts = Persons.ksenia.favoriteProducts
            favoriteProducts.filters = Filter(names: [""])
            navigationController?.pushViewController(favoriteProducts, animated: true)
        case [0,1]:
            let orders = Orders()
            navigationController?.pushViewController(orders, animated: true)
        case [0,2]:
            print("\(profileMenuTextData[indexPath.row])")
        case [0,3]:
            print("\(profileMenuTextData[indexPath.row])")
        case [0,4]:
            print("\(profileMenuTextData[indexPath.row])")
        default:
            print("no menu row")
        }
    }
    
}

// MARK: - SwiftUI
import SwiftUI
struct Person_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let vc = Person()
            return vc
        }.edgesIgnoringSafeArea(.all)
    }
}
