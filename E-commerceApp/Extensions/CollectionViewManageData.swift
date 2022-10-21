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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsMenuCell.reuseId, for: indexPath) as! ProductsMenuCell
                cell.configure(with: itemIdentifier, indexPath: indexPath, filters: filters)
                return cell
            case .products:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCell.reuseId, for: indexPath) as! ProductsCell
                cell.configure(with: itemIdentifier, indexPath: indexPath, products: curentProducts)
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
    
}
