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
    var productsCount: Int = 0
    var productsInAllPrice: Int = 0
    
    private let buyButton: UIButton = {
        let button = UIButton()
        button.configuration = .gray()
        button.configuration?.title = "Перейти к оформлению"
        button.configuration?.subtitle = "263$"
        button.configuration?.baseForegroundColor = .black
        button.configuration?.titleAlignment = .center
//        button.configuration?.cornerStyle = .
        
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
    
    private func inAllPrice() -> Double {
        
        var allSum: [Double] = []
        
        for product in productsToCart {
            if product.discount == nil{
                let sum = Double(product.price * product.count)
                allSum.append(sum)
            }else{
                let sum = Double((product.price * (100 - (product.discount ?? 100))/100) * product.count)
                allSum.append(sum)
            }
        }
        
        let newSum = allSum.reduce(0, +)
        return newSum
    }
    private func productsSumPrice() -> Double {
        
        var allSum: [Double] = []
        
        for product in productsToCart {
            let sum = Double(product.price * product.count)
            allSum.append(sum)
            
        }
        
        let newSum = allSum.reduce(0, +)
        return newSum
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
        productsCount = productsToCart.count
        
        inAllSumData = [
            "\(productsCount)",
            "\(productsSumPrice())",
            "20",
            "\(inAllPrice())",
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
            cell.plusButtonCallback = { [self]
                () in
                cell.stepperCount = cell.stepperCount + 1
                productsCount = productsCount + 1
                productsToCart[indexPath.row].count = productsToCart[indexPath.row].count + 1
                inAllSumData[0] = "\(productsCount)"
                inAllSumData[1] = "\(productsSumPrice())"
                inAllSumData[3] = "\(inAllPrice())"
                cell.stepperLabel.text = "\(cell.stepperCount)"
                collectionView.reloadSections(NSIndexSet(index: 1) as IndexSet)
            }
            cell.minusButtonCallback = { [self]
                () in
                if cell.stepperCount > 1{
                    cell.stepperCount = cell.stepperCount - 1
                    productsCount = productsCount - 1
                    productsToCart[indexPath.row].count = productsToCart[indexPath.row].count - 1
                    inAllSumData[0] = "\(productsCount)"
                    inAllSumData[1] = "\(productsSumPrice())"
                    inAllSumData[3] = "\(inAllPrice())"
                    cell.stepperLabel.text = "\(cell.stepperCount)"
                    collectionView.reloadSections(NSIndexSet(index: 1) as IndexSet)
                }else{
                    cell.stepperCount = cell.stepperCount - 0
                    cell.stepperLabel.text = "\(cell.stepperCount)"
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
