//
//  ItemBadgeSupplementaryViewController.swift
//  SampleModule
//
//  Created by Huy Ong on 8/25/20.
//

import UIKit

class ItemBadgeSupplementaryViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    struct Model: Hashable {
        let title: String
        let badgeCount: Int
        let id = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Model>! = nil
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Item Badges"
        configureCollectionView()
        configureDataSource()
    }
}

extension ItemBadgeSupplementaryViewController {
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<TextCell, Model> { (cell, indexPath, model) in
            cell.label.text = model.title
            cell.contentView.backgroundColor = .systemBlue
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.cornerRadius = 8
            cell.label.textAlignment = .center
            cell.label.font = UIFont.preferredFont(forTextStyle: .title1)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<BadgeSupplementaryView>(elementKind: BadgeSupplementaryView.reuseIdentifier) { (badgeView, string, indexPath) in
            guard let model = self.dataSource.itemIdentifier(for: indexPath) else { return }
            let hasBadgeCount = model.badgeCount > 0
            badgeView.label.text = "\(model.badgeCount)"
            badgeView.isHidden = !hasBadgeCount
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Model>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, model) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: model)
        })
        
        dataSource.supplementaryViewProvider = {
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: $2)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Model>()
        snapshot.appendSections([.main])
        let models = (0...50).map { Model(title: "\($0)", badgeCount: Int.random(in: 0...5)) }
        snapshot.appendItems(models)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], fractionalOffset: CGPoint(x: 0.3, y: -0.3))
        
        let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20), heightDimension: .absolute(20))
        
        let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: "badgeElementKind", containerAnchor: badgeAnchor)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [badge])
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 5, bottom: 20, trailing: 5)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
