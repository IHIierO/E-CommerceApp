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
            return 3
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
//MARK: - ProductsCollectionViewManageData
class ProductsCollectionViewManageData {
    
    var dataSource: UICollectionViewDiffableDataSource<ProductsSectionKind, Int>! = nil
    
    func setupDataSource(collectionView: UICollectionView, view: UIView, tabBarColtroller: UITabBarController, curentProducts: [Product], filters: Filter){
        dataSource = UICollectionViewDiffableDataSource<ProductsSectionKind, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let queue = DispatchQueue.global(qos: .utility)
            let section = ProductsSectionKind(rawValue: indexPath.section)!
            switch section {
            case .menu:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsMenuCell.reuseId, for: indexPath) as! ProductsMenuCell
                queue.async {
                    DispatchQueue.main.async {
                        cell.configure(with: itemIdentifier, indexPath: indexPath, filters: filters)
                    }
                }
                if cell.isSelected {
                    cell.backgroundColor = .red
                }else{
                    cell.backgroundColor = .lightGray
                }
                cell.tag = indexPath.row
                return cell
            case .products:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCell.reuseId, for: indexPath) as! ProductsCell
                queue.async {
                    DispatchQueue.main.async {
                        cell.configure(with: itemIdentifier, indexPath: indexPath, products: curentProducts)
                    }
                }
                cell.addToShoppingCardCallback = { () in
                    ViewControllersHelper.addToCart(products: curentProducts, indexPath: indexPath, view: view, tabBarController: tabBarColtroller)
                    collectionView.reloadData()
                    
                }
                cell.favoriteButtonTapAction = {() in
                    ViewControllersHelper.addToFavorite(products: curentProducts, indexPath: indexPath)
                    collectionView.reloadData()}
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
//MARK: - HomeCollectionViewManageData
class HomeCollectionViewManageData {
    
    var dataSource: UICollectionViewDiffableDataSource<HomeSectionKind, Int>! = nil
    
    func setupDataSource(collectionView: UICollectionView, view: UIView, tabBarColtroller: UITabBarController, products: [Product], curentNewest: [Product], curentTopRated: [Product]){
        dataSource = UICollectionViewDiffableDataSource<HomeSectionKind, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let queue = DispatchQueue.global(qos: .utility)
            let section = HomeSectionKind(rawValue: indexPath.section)!
            let discountsCell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscountsCell.reuseId, for: indexPath) as! DiscountsCell
            let newestCell = collectionView.dequeueReusableCell(withReuseIdentifier: NewestCell.reuseId, for: indexPath) as! NewestCell
            let topRatedCell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCell.reuseId, for: indexPath) as! TopRatedCell
            switch section {
                
            case .discounts:
                queue.async {
                    DispatchQueue.main.async {
                        discountsCell.configure(with: itemIdentifier, indexPath: indexPath)
                    }
                }
                return discountsCell
            case .newest:
                queue.async {
                    DispatchQueue.main.async {
                        newestCell.configure(with: itemIdentifier, indexPath: indexPath, products: curentNewest)
                    }
                }
                newestCell.favoriteButtonTapAction = { () in
                    ViewControllersHelper.addToFavorite(products: curentNewest, indexPath: indexPath)
                    collectionView.reloadData()}
                newestCell.addToShoppingCardCallback = { () in
                    ViewControllersHelper.addToCart(products: curentNewest, indexPath: indexPath, view: view, tabBarController: tabBarColtroller)
                    collectionView.reloadData()}
                return newestCell
            case .topRated:
                queue.async {
                    DispatchQueue.main.async {
                        topRatedCell.configure(with: itemIdentifier, indexPath: indexPath, products: curentTopRated)
                    }
                }
                topRatedCell.favoriteButtonTapAction = {() in
                    ViewControllersHelper.addToFavorite(products: curentTopRated, indexPath: indexPath)
                    collectionView.reloadData()}
                return topRatedCell
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
