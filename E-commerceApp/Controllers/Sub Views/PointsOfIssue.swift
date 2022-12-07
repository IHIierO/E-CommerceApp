//
//  PointsOfIssue.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 01.12.2022.
//

import UIKit

class PointsOfIssue: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var deliveryAdressTappedCallback: (()->())?
    var doneButtonTappedCallback: (()->())?
    var currentIndex: IndexPath = []
    
    let tableView = UITableView()
    let doneButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Выбрать"
        button.configuration?.baseForegroundColor = UIColor(hexString: "#FDFAF3")
        button.configuration?.baseBackgroundColor = UIColor(hexString: "#324B3A")
        button.configuration?.titleAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let saintPetersburg = ["Санкт-Петербург г., ул. Николая Рубцова 12",
                 "Санкт-Петербург г., ул. Николая Рубцова 9",
                 "Санкт-Петербург г., ул. Федора Абрамова 18"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setConstraints()
        doneButton.addTarget(self, action: #selector(dismissChildViewController), for: .touchUpInside)
        
    }
    @objc func dismissChildViewController(){
        doneButtonTappedCallback?()
    }
    
    func setupTableView(){
        view.backgroundColor = UIColor(hexString: "#FDFAF3")
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchCell")
    }
    
    func setConstraints(){
        view.addSubview(doneButton)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            doneButton.widthAnchor.constraint(equalToConstant: 150),
            
            tableView.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saintPetersburg.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        cell.textLabel?.text = saintPetersburg[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath
        deliveryAdressTappedCallback?()
    }
    
}
