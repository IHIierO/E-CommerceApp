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
        button.configuration = .gray()
        button.configuration?.title = "Перейти к оформлению"
        button.configuration?.subtitle = "263 руб."
        button.configuration?.baseForegroundColor = .black
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
        view.backgroundColor = .white
        title = "Корзина"
        setupTableView()
        setConstraints()
    }
    
    private func inAllPrice() -> Int {
        
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
    private func productsSumPrice() -> Int {
        
        var allSum: [Int] = []
        
        for product in Persons.ksenia.productsInCart  {
            let sum = product.price * product.count
            allSum.append(sum)
            
        }
        
        let newSum = allSum.reduce(0, +)
        return newSum
    }
    private func inAllCount() -> Int {
        
        var allSum: [Int] = []
        
        for product in Persons.ksenia.productsInCart  {
            allSum.append(product.count)
        }
       let newSum = allSum.reduce(0, +)
        return newSum
    }
    private func newData() {
        inAllSumData[0] = "\(inAllCount()) шт."
        inAllSumData[1] = "\(productsSumPrice()) руб."
        inAllSumData[2] = "\(productsSumPrice() - inAllPrice()) руб."
        inAllSumData[3] = "\(inAllPrice()) руб."
        buyButton.configuration?.subtitle = "\(inAllPrice()) руб."
    }
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartCellTV.self, forCellReuseIdentifier: CartCellTV.reuseId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "no products")
        tableView.register(PriceCellTV.self, forCellReuseIdentifier: PriceCellTV.reuseId)
        
        buyButton.configuration?.subtitle = "\(inAllPrice())"
        buyButton.addTarget(self, action: #selector(buyButtonTap), for: .touchUpInside)
        
        inAllSumData = [
            "\(inAllCount()) шт.",
            "\(productsSumPrice()) руб.",
            "\(productsSumPrice() - inAllPrice()) руб.",
            "\(inAllPrice()) руб.",
            ]
    }
    private func setConstraints(){
        view.addSubview(buyButton)
        NSLayoutConstraint.activate([
            buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            buyButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: 0)
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
                cell.plusButtonCallback = { [self]
                    () in
                    Persons.ksenia.productsInCart[indexPath.row].count = Persons.ksenia.productsInCart[indexPath.row].count + 1
                    newData()
                    cell.stepperLabel.text = "\(Persons.ksenia.productsInCart[indexPath.row].count)"
                    tableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: .automatic)
                }
                cell.minusButtonCallback = { [self]
                    () in
                    if Persons.ksenia.productsInCart[indexPath.row].count > 1 {
                        Persons.ksenia.productsInCart[indexPath.row].count = Persons.ksenia.productsInCart[indexPath.row].count - 1
                        newData()
                        cell.stepperLabel.text = "\(Persons.ksenia.productsInCart[indexPath.row].count)"
                        tableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: .automatic)
                    }else{
                        Persons.ksenia.productsInCart[indexPath.row].count = Persons.ksenia.productsInCart[indexPath.row].count - 0
                        cell.stepperLabel.text = "\(Persons.ksenia.productsInCart[indexPath.row].count)"
                    }
                }
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "no products", for: indexPath)
                var content = cell.defaultContentConfiguration()
                content.text = "Нет товаров в корзине"
                content.textProperties.alignment = .center
                content.textProperties.font = .systemFont(ofSize: 28)
                content.textProperties.adjustsFontSizeToFitWidth = true
                content.secondaryText = "Пожалуйста выберети товары из каталога"
                content.secondaryTextProperties.alignment = .center
                content.secondaryTextProperties.font = .systemFont(ofSize: 18)
                content.secondaryTextProperties.adjustsFontSizeToFitWidth = true
                cell.contentConfiguration = content
                return cell
            }
            
        case 1:
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
            return CGFloat(20)
        default:
            return CGFloat(20)
        }
    }
    
    //MARK: - Table View Swipe Actions
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complitionHandler in
            
            Persons.ksenia.productsInCart.remove(at: indexPath.row)
            self.newData()
            let tabBar = self.tabBarController as! TabBar
            tabBar.changeBageValue()
            tableView.reloadData()
            
            return complitionHandler(true)
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoriteAction = UIContextualAction(style: .normal, title: "Add to Favorite") { _, _, complitionHandler in
            
            ViewControllersHelper.addToFavorite(products: Persons.ksenia.productsInCart, indexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .none)
            
            return complitionHandler(true)
        }
        favoriteAction.backgroundColor = .magenta
        let configuration = UISwipeActionsConfiguration(actions: [favoriteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
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

