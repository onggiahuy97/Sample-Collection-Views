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
            OutlineItem(title: "Compotisional Layout", subitems: [
                OutlineItem(title: "Getting Started", subitems: [
                    OutlineItem(title: "Grid", viewController: GridViewController.self, url: ""),
                    OutlineItem(title: "Inset Items Grid", viewController: InsetItemsGridViewController.self, url: ""),
                    OutlineItem(title: "Two-Column Grid", viewController: TwoColumnViewController.self),
                    OutlineItem(title: "Per-Section Layout", subitems: [
                        OutlineItem(title: "Distinct Sections", viewController: DistinctSectionsViewController.self),
                        OutlineItem(title: "Adaptive Sections", viewController: AdaptiveSectionsViewController.self)
                    ])
                ])
            ]),
            
            // MARK: - Diffable Data Source
            
            // MARK: - Lists
            
            // MARK: - Outlines
            
            // MARK: - SwiftUI
            OutlineItem(title: "SwiftUI", subitems: [
                OutlineItem(title: "Text", viewController: TextSwiftUIViewController.self),
                OutlineItem(title: "ProgressViews - Indicators", viewController: ProgressViewViewController.self),
                OutlineItem
            ])
        ]
    }()
}
