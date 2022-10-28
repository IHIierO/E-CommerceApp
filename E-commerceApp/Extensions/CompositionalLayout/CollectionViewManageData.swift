//
//  CollectionViewManageData.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 20.10.2022.
//

import UIKit

enum ProductsSectionKind: Int, CaseIterable{
    
case menu, products
    var columnCount: Int {
        switch self {
        case .menu:
            return 4
        case .products:
            return 10
        }
    }
}

enum HomeSectionKind: Int, CaseIterable{
    
case discounts, newest, topRated
    var columnCount: Int {
        switch self {
        case .discounts:
            return 3
        case .newest:
            return 6
        case .topRated:
            return 7
        }
    }
}

class ProductsCollectionViewManageData {
    
    var dataSource: UICollectionViewDiffableDataSource<ProductsSectionKind, Int>! = nil
    
    func setupDataSource(collectionView: UICollectionView, curentProducts: [Product], filters: Filter){
        dataSource = UICollectionViewDiffableDataSource<ProductsSectionKind, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let section = ProductsSectionKind(rawValue: indexPath.section)!
            switch section {
            case .menu:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsMenuCell.reuseId, for: indexPath) as! ProductsMenuCell
                cell.configure(with: itemIdentifier, indexPath: indexPath, filters: filters)
                return cell
            case .products:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCell.reuseId, for: indexPath) as! ProductsCell
                cell.configure(with: itemIdentifier, indexPath: indexPath, products: curentProducts)
                cell.addToShoppingCardCallback = {() in
                    let test = curentProducts
                    for product in products{
                        if product.productName == test[indexPath.row].productName{
                            print("\(test[indexPath.row].productName) addToShoppingCard")
                        }
                    }
                }
                return cell
            }
        })
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath)  in
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as? Header else { fatalError("Header error") }
            let section = ProductsSectionKind(rawValue: indexPath.section)
            switch section{
            case .menu:
                header.headerLabel.text = "Фильтры"
            case .products:
                header.headerLabel.text = "Товары"
            case .none:
                print("error")
            }
            return header
        }
    }
    
    func reloadData(curentProducts: [Product], filters: Filter){
        var snapshot = NSDiffableDataSourceSnapshot<ProductsSectionKind, Int>()
        
        ProductsSectionKind.allCases.forEach { (sectionKind) in
            
            switch sectionKind {
            case .menu:
                let itemPerSection = filters.names.count
                let itemOffset = sectionKind.columnCount * itemPerSection
                let itemUpperbount = itemOffset + itemPerSection
                snapshot.appendSections([.menu])
                snapshot.appendItems(Array(itemOffset..<itemUpperbount))
            case .products:
                    let itemPerSection = curentProducts.count
                    let itemOffset = sectionKind.columnCount * itemPerSection
                    let itemUpperbount = itemOffset + itemPerSection
                snapshot.appendSections([.products])
                    snapshot.appendItems(Array(itemOffset..<itemUpperbount))
            }
        }
        dataSource.applySnapshotUsingReloadData(snapshot)
    }
}

class HomeCollectionViewManageData {
    
    var dataSource: UICollectionViewDiffableDataSource<HomeSectionKind, Int>! = nil
    
    func setupDataSource(collectionView: UICollectionView, products: [Product], curentNewest: [Product], curentTopRated: [Product]){
        dataSource = UICollectionViewDiffableDataSource<HomeSectionKind, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let section = HomeSectionKind(rawValue: indexPath.section)!
            switch section {
                
            case .discounts:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscountsCell.reuseId, for: indexPath) as! DiscountsCell
                cell.configure(with: itemIdentifier, indexPath: indexPath)
                
                return cell
            case .newest:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewestCell.reuseId, for: indexPath) as! NewestCell
                cell.configure(with: itemIdentifier, indexPath: indexPath, products: curentNewest)
                
                return cell
            case .topRated:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCell.reuseId, for: indexPath) as! TopRatedCell
                cell.favoriteButtonTapAction = { () in
                    print("add to favorite")
                }
                cell.configure(with: itemIdentifier, indexPath: indexPath, products: curentTopRated)
                return cell
            }
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath)  in
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as? Header else { fatalError("Header error") }
            let section = HomeSectionKind(rawValue: indexPath.section)
            switch section{
            
            case .discounts:
                header.headerLabel.text = "Акции"
            case .newest:
                header.headerLabel.text = "Новинки"
            case .topRated:
                header.headerLabel.text = "Топ Рейтинг"
            case .none:
                print("error")
            }
            
            return header
        }
    }
    
    func reloadData(curentTopRated: [Product], curentNewest: [Product]){
        var snapshot = NSDiffableDataSourceSnapshot<HomeSectionKind, Int>()
        
        HomeSectionKind.allCases.forEach { (sectionKind) in
            
            switch sectionKind {
            case .discounts:
                let itemPerSection = 4
                let itemOffset = sectionKind.columnCount * itemPerSection
                let itemUpperbount = itemOffset + itemPerSection
                snapshot.appendSections([sectionKind])
                snapshot.appendItems(Array(itemOffset..<itemUpperbount))
            case .newest:
                let itemPerSection = curentNewest.count
                let itemOffset = sectionKind.columnCount * itemPerSection
                let itemUpperbount = itemOffset + itemPerSection
                snapshot.appendSections([sectionKind])
                snapshot.appendItems(Array(itemOffset..<itemUpperbount))
            case .topRated:
                let itemPerSection = curentTopRated.count
                let itemOffset = sectionKind.columnCount * itemPerSection
                let itemUpperbount = itemOffset + itemPerSection
                snapshot.appendSections([sectionKind])
                snapshot.appendItems(Array(itemOffset..<itemUpperbount))
            }
        }
        dataSource.applySnapshotUsingReloadData(snapshot)
    }
}
