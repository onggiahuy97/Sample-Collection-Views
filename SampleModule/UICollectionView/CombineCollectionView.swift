//
//  CombineCollectionView.swift
//  SampleModule
//
//  Created by Huy Ong on 8/21/20.
//

import SwiftUI
import SafariServices

class CombineCollectionView: UIViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, OutlineItem>! = nil
    var collectionView: UICollectionView! = nil
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Sample Collection Views"
        configureCollectionView()
        configureDataSource()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Code", style: .plain, target: self, action: #selector(handleCode))
    }
    
    @objc private func handleCode() {
        guard let url = URL(string: Self.urlString) else { return }
        let sf = SFSafariViewController(url: url)
        present(sf, animated: true, completion: nil)
    }
    
}

extension CombineCollectionView {
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemGroupedBackground
        self.collectionView = collectionView
        collectionView.delegate = self
        
    }
    
    func configureDataSource() {
        let containerCellRegistratrion = UICollectionView.CellRegistration<UICollectionViewListCell, OutlineItem> { (cell, indexPath, menuItem) in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = menuItem.title
            contentConfiguration.textProperties.font = .preferredFont(forTextStyle: .headline)
            cell.contentConfiguration = contentConfiguration
            
            let disclosureOptions = UICellAccessory.OutlineDisclosureOptions(style: .header)
            cell.accessories = [.outlineDisclosure(options: disclosureOptions)]
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OutlineItem> { (cell, indexPath, menuItem) in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = menuItem.title
            cell.contentConfiguration = contentConfiguration
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, OutlineItem>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            if item.subitems.isEmpty {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: containerCellRegistratrion, for: indexPath, item: item)
            }
        })
        
        let snapshot = initialSnapshot()
        self.dataSource.apply(snapshot, to: .main, animatingDifferences: false)
        
    }
    
    func initialSnapshot() -> NSDiffableDataSourceSectionSnapshot<OutlineItem> {
        var snapshot = NSDiffableDataSourceSectionSnapshot<OutlineItem>()
        func addItems(_ menuItems: [OutlineItem], to parent: OutlineItem?) {
            snapshot.append(menuItems, to: parent)
            for menuItem in menuItems where !menuItem.subitems.isEmpty {
                addItems(menuItem.subitems, to: menuItem)
            }
        }
        
        addItems(OutlineItem.menuItems, to: nil)
        return snapshot
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebar)
        let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        return layout
    }
}

extension CombineCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let menuItem = self.dataSource.itemIdentifier(for: indexPath) else { return }
        collectionView.deselectItem(at: indexPath, animated: true)
        if let viewController = menuItem.outlineViewController {
            navigationController?.pushViewController(viewController.init(), animated: true)
        }
    }
}


extension CombineCollectionView {
    static let urlString = "https://github.com/onggiahuy97/Sample-Collection-Views/blob/master/SampleModule/UICollectionView/CombineCollectionView.swift"
}

struct CombineCollectionViewContainer: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let navigationVC = UINavigationController(rootViewController: CombineCollectionView())
        navigationVC.navigationBar.prefersLargeTitles = false
        return navigationVC
        
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct PreviewCombineCollectionView: PreviewProvider {
    static var previews: some View {
        CombineCollectionViewContainer().edgesIgnoringSafeArea(.all)
    }
}
