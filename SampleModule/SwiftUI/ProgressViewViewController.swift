//
//  ProgressViewViewController.swift
//  SampleModule
//
//  Created by Huy Ong on 8/24/20.
//

import SwiftUI

class ProgressViewViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Indicators"
        let aView = UIHostingController(rootView: ProgressViewSwiftUI())
        view.addSubview(aView.view)
        aView.view.frame = view.bounds
    }
}

struct ProgressViewSwiftUI: View {
    var body: some View {
        Form {
            
            SectionView(title: "ProgresView",
                        description: "Simple progress of completion") {
                VStack(spacing: 10) {
                   
                    ProgressView()
                   
                    Divider()
                   
                    ProgressView("Loading...")
                   
                    Divider()
                   
                    ProgressView(value: 0.45,
                                 total: 1.0)
                        .progressViewStyle(LinearProgressViewStyle())
                        .padding(.vertical)
                    
                }
            }
        }
    }
}
