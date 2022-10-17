//
//  Home.swift
//  E-commerceApp
//
//  Created by Artem Vorobev on 12.10.2022.
//

import UIKit

class Home: UIViewController {
    
    enum SectionKind: Int, CaseIterable{
        
    case discounts, collections, topRated
        var columnCount: Int {
            switch self {
            case .discounts:
                return 3
            case .collections:
                return 6
            case .topRated:
                return 7
            }
        }
    }
    
    var dataSource: UICollectionViewDiffableDataSource<SectionKind, Int>! = nil
    
    var collectionView: UICollectionView! = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tabBar = self.tabBarController as! TabBar
        tabBar.showTabBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
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
        collectionView.register(CollectionsCell.self, forCellWithReuseIdentifier: CollectionsCell.reuseId)
        collectionView.register(TopRatedCell.self, forCellWithReuseIdentifier: TopRatedCell.reuseId)
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.delegate = self
        
        setupDataSource()
        reloadData()
        
    }
    
    func configure<T: SelfConfiguringCell>(cellType: T.Type, with itemIdentifier: Int, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError("Error: \(cellType)")}
        cell.configure(with: itemIdentifier, indexPath: indexPath)
        
        return cell
    }
    
    // MARK: - Manage the data in UICollectionView
    private func setupDataSource(){
        dataSource = UICollectionViewDiffableDataSource<SectionKind, Int>(collectionView: collectionView, cellProvider: { [self] (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            let section = SectionKind(rawValue: indexPath.section)!
            switch section {
                
            case .discounts:
                return configure(cellType: DiscountsCell.self, with: itemIdentifier, for: indexPath)
            case .collections:
                return configure(cellType: CollectionsCell.self, with: itemIdentifier, for: indexPath)
            case .topRated:
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCell.reuseId, for: indexPath) as! TopRatedCell
                cell.favoriteButtonTapAction = { () in
                    print("add favorite")
                }
                
                return cell
            }
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath)  in
            
            guard let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as? Header else { fatalError("Header error") }
            let section = SectionKind(rawValue: indexPath.section)
            switch section{
            
            case .discounts:
                header.headerLabel.text = "Акции"
            case .collections:
                header.headerLabel.text = "Коллекции"
            case .topRated:
                header.headerLabel.text = "Топ Рейтинг"
            case .none:
                print("error")
            }
            
            return header
        }
    }
    
    func reloadData(){
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
        
        SectionKind.allCases.forEach { (sectionKind) in
            
            switch sectionKind {
            case .discounts:
                let itemPerSection = 4
                let itemOffset = sectionKind.columnCount * itemPerSection
                let itemUpperbount = itemOffset + itemPerSection
                snapshot.appendSections([sectionKind])
                snapshot.appendItems(Array(itemOffset..<itemUpperbount))
            case .collections:
                let itemPerSection = 8
                let itemOffset = sectionKind.columnCount * itemPerSection
                let itemUpperbount = itemOffset + itemPerSection
                snapshot.appendSections([sectionKind])
                snapshot.appendItems(Array(itemOffset..<itemUpperbount))
            case .topRated:
                let itemPerSection = 6
                let itemOffset = sectionKind.columnCount * itemPerSection
                let itemUpperbount = itemOffset + itemPerSection
                snapshot.appendSections([sectionKind])
                snapshot.appendItems(Array(itemOffset..<itemUpperbount))
            }
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - createLayout
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvirnment) -> NSCollectionLayoutSection? in
            let section = SectionKind(rawValue: sectionIndex)!
            switch section {
            case .discounts:
                return self.createDiscountSection()
            case .collections:
                return self.createCollectionsSection()
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
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createCollectionsSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.25),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func createTopRatedSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
}

extension Home: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = SectionKind(rawValue: indexPath.section)
        
        switch section{
        case .discounts:
            let discountsPopup = DiscountsPopup()
            discountsPopup.config(indexPath: indexPath)
            discountsPopup.moreInfoButtonTappedCallback = {
                () in
                discountsPopup.animateOut()
                let discounts = Discounts()
                discounts.discountData = discountsPopup.discountData
                discounts.config(indexPath: indexPath)
                self.navigationController?.pushViewController(discounts, animated: true)
            }
            view.addSubview(discountsPopup)
        case .collections:
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
struct TabBarProvider: PreviewProvider{
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable{
        let tabBar = TabBar()
        func makeUIViewController(context: Context) -> some TabBar {
            return tabBar
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}

