//
//  ListAppearancesViewController.swift
//  SampleModule
//
//  Created by Huy Ong on 8/26/20.
//

import UIKit

class ListAppearancesViewController: UIViewController {
    private struct Item: Hashable {
        let title: String?
        private let identifier = UUID()
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Item>! = nil
    private var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "List Appearances"
        setupCollectionView()
        configureDataSource()
        updateBarButtonItem()
    }
    
    private var appearance = UICollectionLayoutListConfiguration.Appearance.plain
    
    @objc
    private func changeListAppearance() {
        switch appearance {
        case .plain:
            appearance = .sidebarPlain
        case .sidebarPlain:
            appearance = .sidebar
        case .sidebar:
            appearance = .grouped
        case .grouped:
            appearance = .insetGrouped
        case .insetGrouped:
            appearance = .plain
        default:
            break
        }
        let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first
        dataSource.apply(dataSource.snapshot(), animatingDifferences: false)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        updateBarButtonItem()
    }
    
    private func updateBarButtonItem() {
        var title: String? = nil
        switch appearance {
        case .plain: title = "Plain"
        case .sidebarPlain: title = "Sidebar Plain"
        case .sidebar: title = "Sidebar"
        case .grouped: title = "Group"
        case .insetGrouped: title = "Inset Group"
        default: break
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(changeListAppearance))
    }
}

extension ListAppearancesViewController {
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (section, layoutEnvironment) -> NSCollectionLayoutSection? in
            var config = UICollectionLayoutListConfiguration(appearance: self.appearance)
            config.headerMode = .firstItemInSection
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
        }
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
    }
    
    private func configureDataSource() {
        let headerRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { [weak self] (cell, indexPath, item) in
            guard let self = self else { return }
            
            var content = cell.defaultContentConfiguration()
            switch self.appearance {
            case .grouped, .insetGrouped:
                content.text = item.title?.localizedUppercase
            default:
                content.text = item.title
            }
            cell.contentConfiguration = content
            cell.accessories = [.outlineDisclosure()]
        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { [weak self] (cell, indexPath, item) in
            guard let self = self else { return }
            
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
            
            switch self.appearance {
            case .sidebar, .sidebarPlain:
                cell.accessories = []
            default:
                cell.accessories = [.disclosureIndicator()]
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Item>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            if indexPath.item == 0 {
                return collectionView.dequeueConfiguredReusableCell(using: headerRegistration, for: indexPath, item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            }
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        let sections = Array(0..<5)
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: false)
        for section in sections {
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
            let headerItem = Item(title: "Section \(section)")
            sectionSnapshot.append([headerItem])
            let items = Array(0..<3).map { Item(title: "Item \($0)") }
            sectionSnapshot.append(items, to: headerItem)
            sectionSnapshot.expand([headerItem])
            dataSource.apply(sectionSnapshot, to: section)
        }
        
        
    }
    
}
