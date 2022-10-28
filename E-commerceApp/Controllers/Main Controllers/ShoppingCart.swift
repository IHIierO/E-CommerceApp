//
//  ShoppingCart.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//

import UIKit

class ShoppingCart: UIViewController {
  
    var productsToCart = products.filter({$0.shoppingCart == true})
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
    private var collectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Корзина"
        setupCollectionView()
        setConstraints()
    }
    
    private func inAllPrice() -> Int {
        
        var allSum: [Int] = []
        
        for product in productsToCart {
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
        
        for product in productsToCart {
            let sum = product.price * product.count
            allSum.append(sum)
            
        }
        
        let newSum = allSum.reduce(0, +)
        return newSum
    }
    private func inAllCount() -> Int {
        
        var allSum: [Int] = []
        
        for product in productsToCart {
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
    
    private func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 20, left: 10, bottom: 20, right: 10)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CartCell.self, forCellWithReuseIdentifier: CartCell.reuseId)
        collectionView.register(PriceCell.self, forCellWithReuseIdentifier: PriceCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
        buyButton.configuration?.subtitle = "\(inAllPrice())"
        
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
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: 0)
        ])
    }

}
//MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension ShoppingCart: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.width/2)
        case 1:
            return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.width/6)
        default:
            return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.width/2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0: return 20
        case 1: return 0
        default: return 20
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return productsToCart.count
        case 1: return 4
        default: return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCell.reuseId, for: indexPath) as! CartCell
            cell.configure(indexPath: indexPath, products: productsToCart)
            cell.stepperLabel.text = "\(productsToCart[indexPath.row].count)"
            cell.plusButtonCallback = { [self]
                () in
                productsToCart[indexPath.row].count = productsToCart[indexPath.row].count + 1
                newData()
                cell.stepperLabel.text = "\(productsToCart[indexPath.row].count)"
                collectionView.reloadSections(NSIndexSet(index: 1) as IndexSet)
                print("\(products)")
            }
            cell.minusButtonCallback = { [self]
                () in
                if productsToCart[indexPath.row].count > 1 {
                    productsToCart[indexPath.row].count = productsToCart[indexPath.row].count - 1
                    newData()
                    cell.stepperLabel.text = "\(productsToCart[indexPath.row].count)"
                    collectionView.reloadSections(NSIndexSet(index: 1) as IndexSet)
                }else{
                    productsToCart[indexPath.row].count = productsToCart[indexPath.row].count - 0
                    cell.stepperLabel.text = "\(productsToCart[indexPath.row].count)"
                }
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PriceCell.reuseId, for: indexPath) as! PriceCell
            cell.config(indexPath: indexPath)
            cell.inAllSum.text = inAllSumData[indexPath.row]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PriceCell.reuseId, for: indexPath) as! PriceCell
            cell.config(indexPath: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        productsToCart[indexPath.row].shoppingCart = false
        productsToCart[indexPath.row].count = 0
        productsToCart.remove(at: indexPath.row)
        newData()
        collectionView.reloadData()
     }
}

// MARK: - SwiftUI
import SwiftUI
struct ShoppingCart_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let vc = ShoppingCart()
            return vc
        }.edgesIgnoringSafeArea(.all)
    }
}
