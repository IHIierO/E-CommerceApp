//
//  ShoppingCartTV.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 07.11.2022.
//

import UIKit

class ShoppingCartTV: UIViewController {
    var inAllSumData: [String] = []
    
    private let buyButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Перейти к оформлению"
        button.configuration?.baseForegroundColor = UIColor(hexString: "#FDFAF3")
        button.configuration?.baseBackgroundColor = UIColor(hexString: "#324B3A")
        button.configuration?.titleAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        newData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#FDFAF3")
        setupTableView()
        setConstraints()
        setupNavigationController()
    }
    
    func inAllPrice() -> Int {
        
        var allSum: [Int] = []
        
        for product in Persons.ksenia.productsInCart {
            if product.discount == nil{
                let sum = product.price * product.count
                allSum.append(sum)
            }else{
                let sum = (product.price * (100 - (product.discount ?? 100))/100) * product.count
                allSum.append(sum)
            }
        }
        
        let newSum = allSum.reduce(0, +)
        return newSum
    }
    func productsSumPrice() -> Int {
        
        var allSum: [Int] = []
        
        for product in Persons.ksenia.productsInCart  {
            let sum = product.price * product.count
            allSum.append(sum)
            
        }
        
        let newSum = allSum.reduce(0, +)
        return newSum
    }
    func inAllCount() -> Int {
        
        var allSum: [Int] = []
        
        for product in Persons.ksenia.productsInCart  {
            allSum.append(product.count)
        }
       let newSum = allSum.reduce(0, +)
        return newSum
    }
    func newData() {
        inAllSumData[0] = "\(inAllCount()) шт."
        inAllSumData[1] = "\(productsSumPrice()) ₽"
        inAllSumData[2] = "\(productsSumPrice() - inAllPrice()) ₽"
        inAllSumData[3] = "\(inAllPrice()) ₽"
        buyButton.configuration?.subtitle = "\(inAllPrice()) ₽"
    }
    
    private func setupNavigationController(){
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)]
        navigationItem.title = "Корзина"
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.tintColor = UIColor(hexString: "#393C39")
//        self.navigationController?.view.backgroundColor = .clear
    }
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartCellTV.self, forCellReuseIdentifier: CartCellTV.reuseId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "no products")
        tableView.register(PriceCellTV.self, forCellReuseIdentifier: PriceCellTV.reuseId)
        
        buyButton.configuration?.subtitle = "\(inAllPrice())"
        buyButton.addTarget(self, action: #selector(buyButtonTap), for: .touchUpInside)
        
        inAllSumData = [
            "\(inAllCount()) шт.",
            "\(productsSumPrice()) ₽",
            "\(productsSumPrice() - inAllPrice()) ₽",
            "\(inAllPrice()) ₽",
            ]
    }
    private func setConstraints(){
        view.addSubview(tableView)
        view.addSubview(buyButton)
        NSLayoutConstraint.activate([
            buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            buyButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: -10)
        ])
    }
    
    @objc func buyButtonTap(){
        
        if Persons.ksenia.productsInCart.count > 0{
            let orderPopup = OrderPopup()
            orderPopup.orderButtonTappedCallback = { [self] () in
                let newOrder = OrdersModel(deliveryStatus: false, deliveryDate: "\(orderPopup.deliveryDate.text!)", deliveryTime: "\(orderPopup.deliveryTime.text!)", recipientName: Persons.ksenia.name, recipientNumber: "+79146948930", deliveryMethod: "\(orderPopup.deliveryMethod.text!)", deliveryAdress: "\(orderPopup.deliveryAdress.text!)", paymentMethod: "\(orderPopup.paymentMethod.text!)", inAllSumData: inAllSumData, productsInOrder: Persons.ksenia.productsInCart)
                Persons.ksenia.orders.append(newOrder)
                orderPopup.animateOut()
                let addToOrder = NotificationPopup()
                addToOrder.label.text = "Добавлено"
                view.addSubview(addToOrder)
                Persons.ksenia.productsInCart.removeAll()
                let tabBar = tabBarController as! TabBar
                tabBar.changeBageValue()
                tableView.reloadData()
                newData()
//                #warning("Логика согранения заказа")
                
            }
            view.addSubview(orderPopup)
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ShoppingCartTV: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Table View Data
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if !Persons.ksenia.productsInCart.isEmpty {
                return Persons.ksenia.productsInCart.count
            }else{
                return 1
            }
        case 1: if !Persons.ksenia.productsInCart.isEmpty {
            return 4
        }else{
            return 0
        }
        default: return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0 :
            if !Persons.ksenia.productsInCart.isEmpty{
                let cell = tableView.dequeueReusableCell(withIdentifier: CartCellTV.reuseId, for: indexPath) as! CartCellTV
                cell.configure(indexPath: indexPath, products: Persons.ksenia.productsInCart )
                cell.stepperLabel.text = "\(Persons.ksenia.productsInCart [indexPath.row].count)"
                CellsHelpers.stepperHelper(cell: cell, indexPath: indexPath, tableView: tableView, vc: self)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "no products", for: indexPath)
                CellsHelpers.configurationCartCellWhenCartIsEmpty(cell: cell)
                return cell
            }
            
        case 1:
            tableView.separatorStyle = .singleLine
            let cell = tableView.dequeueReusableCell(withIdentifier: PriceCellTV.reuseId, for: indexPath) as! PriceCellTV
            cell.config(indexPath: indexPath)
            cell.inAllSum.text = inAllSumData[indexPath.row]
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "no products", for: indexPath)
            cell.backgroundColor = .red
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return CGFloat(tableView.frame.height / 5)
        case 1:
            return CGFloat(tableView.frame.width / 10)
        default:
            return CGFloat(20)
        }
    }
    
    //MARK: - Table View Swipe Actions
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить из корзины") { _, _, complitionHandler in
            
            Persons.ksenia.productsInCart.remove(at: indexPath.row)
            self.newData()
            let tabBar = self.tabBarController as! TabBar
            tabBar.changeBageValue()
            tableView.reloadData()
            
            return complitionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: "Отложить покупку") { _, _, complitionHandler in
            
            ViewControllersHelper.addToFavorite(products: Persons.ksenia.productsInCart, indexPath: indexPath)
            Persons.ksenia.productsInCart.remove(at: indexPath.row)
            self.newData()
            let tabBar = self.tabBarController as! TabBar
            tabBar.changeBageValue()
            let addToFavoritePopup = NotificationPopup()
            addToFavoritePopup.label.text = "Добавлен в избранное"
            self.view.addSubview(addToFavoritePopup)
            tableView.reloadData()
            
            return complitionHandler(true)
        }
        favoriteAction.backgroundColor = .orange
        let configuration = UISwipeActionsConfiguration(actions: [favoriteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
//  func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
//        if let swipeContainerView = tableView.subviews.first(where: { String(describing: type(of: $0)) == "_UITableViewCellSwipeContainerView" }) {
//            if let swipeActionPullView = swipeContainerView.subviews.first, String(describing: type(of: swipeActionPullView)) == "UISwipeActionPullView" {
//                swipeActionPullView.frame.size.height -= 16
//                swipeActionPullView.frame.origin.y += 8
//                swipeActionPullView.layer.cornerRadius = 8
//                swipeActionPullView.clipsToBounds = true
//                swipeActionPullView.layer.shadowRadius = 8
//                swipeActionPullView.layer.shadowOpacity = 0.8
//                swipeActionPullView.layer.shadowOffset = .zero
//                swipeActionPullView.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
//                swipeActionPullView.layer.masksToBounds = false
//                if let swipeActionStandardButton = swipeActionPullView.subviews.first, String(describing: type(of: swipeActionStandardButton)) == "UISwipeActionStandardButton" {
//                    swipeActionStandardButton.layer.cornerRadius = 8
//                    swipeActionStandardButton.clipsToBounds = true
//                }
//            }
//        }
//    }

}

// MARK: - SwiftUI
import SwiftUI
struct ShoppingCartTV_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let vc = TabBar()
            return vc
        }.edgesIgnoringSafeArea(.all)
    }
}

