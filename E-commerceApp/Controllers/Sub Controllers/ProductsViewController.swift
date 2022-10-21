//
//  ProductsViewController.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 17.10.2022.
//

import UIKit

class ProductsViewController: UIViewController {
    var curentProducts: [Product] = []
    var filters: Filter! = nil
    
    var collectionView: UICollectionView! = nil
    
    private let searchBar = UISearchController(searchResultsController: nil)
    private var search = false
    
    let collectionViewManageData = ProductsCollectionViewManageData()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tabBar = self.tabBarController as! TabBar
        tabBar.showTabBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationController()
    }
    
    private func setupNavigationController(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor(hexString: "#393C39")
        self.navigationController?.view.backgroundColor = .clear
        navigationItem.searchController = searchBar
    }

    private func setupCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor(hexString: "#f5f5dc")
        view.addSubview(collectionView)
        collectionView.register(ProductsMenuCell.self, forCellWithReuseIdentifier: ProductsMenuCell.reuseId)
        collectionView.register(ProductsCell.self, forCellWithReuseIdentifier: ProductsCell.reuseId)
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.delegate = self
        collectionViewManageData.setupDataSource(collectionView: collectionView, curentProducts: curentProducts, filters: filters)
        collectionViewManageData.reloadData(curentProducts: curentProducts, filters: filters)
    }
 
    // MARK: - createLayout
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvirnment) -> NSCollectionLayoutSection? in
            
            let section = ProductsSectionKind(rawValue: sectionIndex)!
            switch section {
            case .menu:
                return self.createMenuSection()
            case .products:
                return self.createProductsSection()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10
        layout.configuration = config
        
        return layout
    }
    
    private func createMenuSection() -> NSCollectionLayoutSection {
        let item = CreateSection.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 8)
        let group = CreateSection.createGroup(alignment: .horizontal, width: .fractionalWidth(0.3), height: .fractionalWidth(0.125), item: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4)
//        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
//        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createProductsSection() -> NSCollectionLayoutSection {
        let item = CreateSection.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 4)
        let group = CreateSection.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(0.35), item: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(24))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
}

// MARK: - UICollectionViewDelegate
extension ProductsViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = ProductsSectionKind(rawValue: indexPath.section)
        
        switch section {
            
        case .menu:
            switch indexPath{
            case [0,0]:
                collectionViewManageData.setupDataSource(collectionView: collectionView, curentProducts: curentProducts, filters: filters)
                collectionViewManageData.reloadData(curentProducts: curentProducts, filters: filters)
//                collectionView.reloadData()
            case [0,1]:
                if title == "Для рук"{
                    let ocurentMl = curentProducts.filter({$0.volume == 50})
                    collectionViewManageData.setupDataSource(collectionView: collectionView, curentProducts: ocurentMl, filters: filters)
                    collectionViewManageData.reloadData(curentProducts: ocurentMl, filters: filters)
    //                collectionView.reloadData()
                }
                
                if title == "Для волос"{
                    let ocurentMl = curentProducts.filter({$0.volume == 100})
                    collectionViewManageData.setupDataSource(collectionView: collectionView, curentProducts: ocurentMl, filters: filters)
                    collectionViewManageData.reloadData(curentProducts: ocurentMl, filters: filters)
    //                collectionView.reloadData()
                }
                
            case [0,2]:
                if title == "Для рук"{
                    let ocurentMl = curentProducts.filter({$0.volume == 125})
                    collectionViewManageData.setupDataSource(collectionView: collectionView, curentProducts: ocurentMl, filters: filters)
                    collectionViewManageData.reloadData(curentProducts: ocurentMl, filters: filters)
    //                collectionView.reloadData()
                }
                
                if title == "Для волос"{
                    let ocurentMl = curentProducts.filter({$0.volume == 200})
                    collectionViewManageData.setupDataSource(collectionView: collectionView, curentProducts: ocurentMl, filters: filters)
                    collectionViewManageData.reloadData(curentProducts: ocurentMl, filters: filters)
    //                collectionView.reloadData()
                }
            default:
                print("error")
            }
        case .products:
            print("error")
        case .none:
            print("error")
        }
    }
}

// MARK: - SwiftUI
import SwiftUI
struct ProductsViewController_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let vc = TabBar()
            return vc
        }.edgesIgnoringSafeArea(.all)
    }
}
