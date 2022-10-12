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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupCollectionView()
    }

    private func setupCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor(hexString: "#f5f5dc")
        view.addSubview(collectionView)
        
        collectionView.register(DiscountsCell.self, forCellWithReuseIdentifier: DiscountsCell.reuseId)
        collectionView.register(CollectionsCell.self, forCellWithReuseIdentifier: CollectionsCell.reuseId)
        collectionView.register(TopRatedCell.self, forCellWithReuseIdentifier: TopRatedCell.reuseId)
        
        setupDataSource()
        reloadData()
        
    }
    
    func configure<T: SelfConfiguringCell>(cellType: T.Type, with itemIdentifier: Int, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError("Error: \(cellType)")}
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
                return configure(cellType: TopRatedCell.self, with: itemIdentifier, for: indexPath)
            }
        })
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
        return section
    }
}

extension Home: TapButtonProtocol{
    
    func buttonTapped() {
        print("Add to Favorite")
    }
}

// MARK: - SwiftUI
import SwiftUI
struct FlowProvider: PreviewProvider{
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

