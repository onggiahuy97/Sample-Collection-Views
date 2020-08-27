//
//  ColorSwiftUIVC.swift
//  SampleModule
//
//  Created by Huy Ong on 8/25/20.
//

import SwiftUI

class ColorsSwiftUIVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Basic Colors"
        let aView = UIHostingController(rootView: ColorsView())
        view.addSubview(aView.view)
        aView.view.frame = view.bounds
    }
}
