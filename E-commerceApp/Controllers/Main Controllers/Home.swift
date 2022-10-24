//
//  Home.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//

import UIKit

class Home: UIViewController {
    
    var collectionView: UICollectionView! = nil
    let collectionViewManageData = HomeCollectionViewManageData()
    
    var curentTopRated = products.filter({$0.rating >= 10})
    var curentNewest = products.filter({$0.newest == true})
    
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
    }

    private func setupCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor(hexString: "#f5f5dc")
        view.addSubview(collectionView)
        collectionView.register(DiscountsCell.self, forCellWithReuseIdentifier: DiscountsCell.reuseId)
        collectionView.register(NewestCell.self, forCellWithReuseIdentifier: NewestCell.reuseId)
        collectionView.register(TopRatedCell.self, forCellWithReuseIdentifier: TopRatedCell.reuseId)
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.delegate = self
        
        // MARK: - Manage the data in UICollectionView
        collectionViewManageData.setupDataSource(collectionView: collectionView, products: products, curentNewest: curentNewest, curentTopRated: curentTopRated)
        collectionViewManageData.reloadData(curentTopRated: curentTopRated, curentNewest: curentNewest)
    }
    
    // MARK: - createLayout
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvirnment) -> NSCollectionLayoutSection? in
            let section = HomeSectionKind(rawValue: sectionIndex)!
            switch section {
            case .discounts:
                return self.createDiscountSection()
            case .newest:
                return self.createNewestSection()
            case .topRated:
                return self.createTopRatedSection()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
    private func createDiscountSection() -> NSCollectionLayoutSection {
        let item = CreateSection.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 8)
        let group = CreateSection.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalWidth(0.5), item: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    private func createNewestSection() -> NSCollectionLayoutSection {
        let item = CreateSection.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 8)
        let group = CreateSection.createGroup(alignment: .horizontal, width: .fractionalWidth(0.45), height: .fractionalWidth(0.7), item: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    private func createTopRatedSection() -> NSCollectionLayoutSection {
        let item = CreateSection.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 8)
        let group = CreateSection.createGroup(alignment: .horizontal, width: .fractionalWidth(0.93), height: .fractionalWidth(0.6), item: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
}

// MARK: - UICollectionViewDelegate
extension Home: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = HomeSectionKind(rawValue: indexPath.section)
        
        switch section{
        case .discounts:
            switch indexPath{
            case [0,0]:
                ViewControllersHelper.pushToDiscount(indexPath: indexPath, view: view, discontPircent: 10, navigationController: navigationController!)
            case [0,1]:
                ViewControllersHelper.pushToDiscount(indexPath: indexPath, view: view, discontPircent: 20, navigationController: navigationController!)
            case [0,2]:
                ViewControllersHelper.pushToDiscount(indexPath: indexPath, view: view, discontPircent: 30, navigationController: navigationController!)
            default:
                print("no index")
            }
        case .newest:
            print("\(section)")
        case .topRated:
            print("\(section)")
        case .none:
            print("error")
        }
    }
}

// MARK: - SwiftUI
import SwiftUI
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            let vc = TabBar()
            return vc
        }.edgesIgnoringSafeArea(.all)
    }
}

