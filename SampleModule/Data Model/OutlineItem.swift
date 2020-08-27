//
//  OutlineItem.swift
//  SampleModule
//
//  Created by Huy Ong on 8/23/20.
//

import UIKit

class OutlineItem: Hashable {
    let title: String
    let subitems: [OutlineItem]
    let url: String
    let outlineViewController: UIViewController.Type?
    
    init(title: String,
         viewController: UIViewController.Type? = nil,
         url: String = "",
         subitems: [OutlineItem] = []) {
        self.title = title
        self.subitems = subitems
        self.url = url
        self.outlineViewController = viewController
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: OutlineItem, rhs: OutlineItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private let identifier = UUID()
}

extension OutlineItem {
    static var menuItems: [OutlineItem] = {
        return [
            // MARK: - Compositional Layout
            OutlineItem(title: "Compositional Layout", subitems: [
                OutlineItem(title: "Getting Started", subitems: [
                    OutlineItem(title: "Grid", viewController: GridViewController.self, url: ""),
                    OutlineItem(title: "Inset Items Grid", viewController: InsetItemsGridViewController.self, url: ""),
                    OutlineItem(title: "Two-Column Grid", viewController: TwoColumnViewController.self),
                    OutlineItem(title: "Per-Section Layout", subitems: [
                        OutlineItem(title: "Distinct Sections", viewController: DistinctSectionsViewController.self),
                        OutlineItem(title: "Adaptive Sections", viewController: AdaptiveSectionsViewController.self)
                    ])
                ]),
                OutlineItem(title: "Advanced Layouts", subitems: [
                    OutlineItem(title: "Supplementary Views", subitems: [
                        OutlineItem(title: "Item Badges", viewController: ItemBadgeSupplementaryViewController.self),
                        OutlineItem(title: "Section Headers/Footers",
                                    viewController: SectionHeadersFootersViewController.self),
                        OutlineItem(title: "Pinned Section Headers",
                                    viewController: PinnedSectionHeaderFooterViewController.self)
                    ]),
                    OutlineItem(title: "Section with Background View", viewController: SectionDecorationViewController.self),
                    OutlineItem(title: "Nested Groups", viewController: NestedGroupsViewController.self),
                    OutlineItem(title: "Orthogonal Sections", subitems: [
                        OutlineItem(title: "Orthogonal Sections",
                                    viewController: OrthogonalScrollingViewController.self),
                        OutlineItem(title: "Orthogonal Section Behaviors",
                                    viewController: OrthogonalScrollBehaviorViewController.self)
                    ])
                ])
            ]),
            
            // MARK: - Diffable Data Source
            
            // MARK: - Lists
            OutlineItem(title: "Lists", subitems: [
//                OutlineItem(title: "Simple List", viewController: SimpleListViewController.self),
                OutlineItem(title: "List Appearances", viewController: ListAppearancesViewController.self),
//                OutlineItem(title: "List with Custom Cells", viewController: CustomCellListViewController.self)
            ]),
            // MARK: - Outlines
            
            // MARK: - SwiftUI
            OutlineItem(title: "SwiftUI", subitems: [
                OutlineItem(title: "Text", viewController: TextSwiftUIViewController.self),
                OutlineItem(title: "Buttons", viewController: ButtonsSwiftUIVC.self),
                OutlineItem(title: "System Controls", viewController: SystemControlsSwiftUIVC.self),
                OutlineItem(title: "Basic Colors", viewController: ColorsSwiftUIVC.self),
                OutlineItem(title: "Haptics", viewController: HapticsViewController.self),
                OutlineItem(title: "Fonts", viewController: FontsViewController.self),
                OutlineItem(title: "ProgressViews - Indicators", viewController: ProgressViewViewController.self),
            ])
        ]
    }()
}
