//
//  SectionView.swift
//  SampleModule
//
//  Created by Huy Ong on 8/24/20.
//

import SwiftUI

struct SectionView<Content: View>: View {
    var title: String?
    var description: String?
    let content: () -> Content
    
    var body: some View {
        Section(footer: Text(description ?? "")) {
            if let title = title {
                Text(title)
                    .font(.headline)
            }
            content()
        }
    }
}
