//
//  FontsViewController.swift
//  SampleModule
//
//  Created by Huy Ong on 8/25/20.
//

import SwiftUI

class FontsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Fonts"
        let aView = UIHostingController(rootView: FontsView())
        view.addSubview(aView.view)
        aView.view.frame = view.bounds
    }
}

struct FontsView: View {
    
    private struct BasicFont: Identifiable {
        let id = UUID()
        var name: String
        var font: Font
        var description: String
    }
    
    private var fonts: [BasicFont] = [
        BasicFont(name: "largeTitle", font: .largeTitle,
                  description: "A font with the large title text style."),
        BasicFont(name: "title", font: .title,
                  description: "A font with the title text style"),
        BasicFont(name: "title2", font: .title2,
                  description: "Create a font for second level hierarchical headings."),
        BasicFont(name: "title3", font: .title3,
                  description: "Create a font for third level hierarchical headings."),
        BasicFont(name: "headline", font: .headline,
                  description: "A font with the headline text style."),
        BasicFont(name: "subheadline", font: .subheadline,
                  description: "A font with the subheadline text style."),
        BasicFont(name: "body", font: .body,
                  description: "A font with the body text style."),
        BasicFont(name: "callout", font: .callout,
                  description: "A font with the callout text style."),
        BasicFont(name: "caption", font: .caption,
                  description: "A font with the caption text style."),
        BasicFont(name: "caption2", font: .caption2,
                  description: "Create a font with the alternate caption text style."),
        BasicFont(name: "footnote", font: .footnote,
                  description: "A font with the footnote text style.")
    ]
    
    var body: some View {
        Form {
            ForEach(fonts) { font in
                SectionView(description: font.description) {
                    Text(font.name).font(font.font)
                }
            }
        }
    }
}
