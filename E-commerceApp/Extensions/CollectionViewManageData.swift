//
//  CollectionViewManageData.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 20.10.2022.
//

import UIKit

enum SectionKind: Int, CaseIterable{
    
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

class CollectionViewManageData {
    
    var dataSource: UICollectionViewDiffableDataSource<SectionKind, Int>! = nil
    
    func setupDataSource(collectionView: UICollectionView, curentProducts: [Product], filters: Filter){
        dataSource = UICollectionViewDiffableDataSource<SectionKind, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let section = SectionKind(rawValue: indexPath.section)!
            switch section {
                
            case .menu:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menu", for: indexPath)
                let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height))
//                title.text = "\(filters.names[indexPath.row])"
                title.text = "test"
                title.textAlignment = .center
                cell.contentView.addSubview(title)
                cell.backgroundColor = .blue
                cell.layer.cornerRadius = 10
                return cell
            case .products:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "products", for: indexPath)
                let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: 50))
                title.text = "\(curentProducts[indexPath.row].productName)"
//                title.text = "Test"
                title.font = UIFont(name: "AvenirNext-Bold", size: 15)
                title.textAlignment = .center
                cell.contentView.addSubview(title)
                cell.backgroundColor = .red
                cell.layer.cornerRadius = 10
                return cell
            }
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath)  in
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as? Header else { fatalError("Header error") }
            let section = SectionKind(rawValue: indexPath.section)
            switch section{
            case .menu:
                header.headerLabel.text = ""
            case .products:
                header.headerLabel.text = "Товары"
            case .none:
                print("error")
            }
            return header
        }
        
    }
    
    func reloadData(curentProducts: [Product], filters: Filter){
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
        
        SectionKind.allCases.forEach { (sectionKind) in
            
            switch sectionKind {
            case .menu:
                let itemPerSection = filters.names.count
                let itemOffset = sectionKind.columnCount * itemPerSection
                let itemUpperbount = itemOffset + itemPerSection
                snapshot.appendSections([.menu])
                snapshot.appendItems(Array(itemOffset..<itemUpperbount))
//                snapshot.reconfigureItems(Array(itemOffset..<itemUpperbount))
            case .products:
                    let itemPerSection = curentProducts.count
                    let itemOffset = sectionKind.columnCount * itemPerSection
                    let itemUpperbount = itemOffset + itemPerSection
                snapshot.appendSections([.products])
                    snapshot.appendItems(Array(itemOffset..<itemUpperbount))
//                snapshot.reconfigureItems(Array(itemOffset..<itemUpperbount))
            }
        }
        dataSource.applySnapshotUsingReloadData(snapshot)
    }
    
    func setupDataSourceForOneTwoFive(collectionView: UICollectionView, curentProducts: [Product], filters: [String]){
        dataSource = UICollectionViewDiffableDataSource<SectionKind, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let section = SectionKind(rawValue: indexPath.section)!
            switch section {
                
            case .menu:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menu", for: indexPath)
                let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height))
                title.text = "\(filters[indexPath.row])"
                title.textAlignment = .center
                cell.contentView.addSubview(title)
                cell.backgroundColor = .blue
                cell.layer.cornerRadius = 10
                return cell
            case .products:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "products", for: indexPath)
                let title = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: 50))
                title.text = "\(curentProducts[indexPath.row].productName)"
//                title.text = "Test"
                title.font = UIFont(name: "AvenirNext-Bold", size: 15)
                title.textAlignment = .center
                cell.contentView.addSubview(title)
                cell.backgroundColor = .red
                cell.layer.cornerRadius = 10
                return cell
            }
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath)  in
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as? Header else { fatalError("Header error") }
            let section = SectionKind(rawValue: indexPath.section)
            switch section{
            case .menu:
                header.headerLabel.text = ""
            case .products:
                header.headerLabel.text = "Товары"
            case .none:
                print("error")
            }
            return header
        }
    }
    
    func reloadDataForOneTwoFive(products: [Product], filters: [String]){
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
        SectionKind.allCases.forEach { (sectionKind) in
            
            switch sectionKind {
            case .menu:
                let itemPerSection = filters.count
                let itemOffset = sectionKind.columnCount * itemPerSection
                let itemUpperbount = itemOffset + itemPerSection
                snapshot.appendSections([.menu])
                snapshot.appendItems(Array(itemOffset..<itemUpperbount))
                snapshot.reconfigureItems(Array(itemOffset..<itemUpperbount))
            case .products:
                let itemPerSection = products.count
                let itemOffset = sectionKind.columnCount * itemPerSection
                let itemUpperbount = itemOffset + itemPerSection
                snapshot.appendSections([.products])
                snapshot.appendItems(Array(itemOffset..<itemUpperbount))
                //                    snapshot.reloadSections([.products])
                snapshot.reconfigureItems(Array(itemOffset..<itemUpperbount))
            }
        }
            dataSource.applySnapshotUsingReloadData(snapshot)
        
    }
}
