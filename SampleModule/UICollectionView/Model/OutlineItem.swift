//
//  OutlineItem.swift
//  SampleModule
//
//  Created by Huy Ong on 8/22/20.
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
    static var menuItems: [OutlineItem] = [
        OutlineItem(title: "Compotisional Layout", subitems: [
            OutlineItem(title: "Getting Started", subitems: [
                OutlineItem(title: "Grid", viewController: GridViewController.self, url: "")
            ])
        ])
    ]
}

class SampleController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
