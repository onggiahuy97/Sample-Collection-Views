//
//  TextSwiftUIViewController.swift
//  SampleModule
//
//  Created by Huy Ong on 8/24/20.
//

import SwiftUI

class TextSwiftUIViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Text"
        let aView = UIHostingController(rootView: TextSwiftUI())
        view.addSubview(aView.view)
        aView.view.frame = view.bounds
    }
}

struct TextSwiftUI: View {
    @State private var text = ""
    @State private var password = ""
    @State private var textEditor = ""
    
    var body: some View {
        Form {
            SectionView(
                title: "Text",
                description: "A read-only text. It can display one or more lines of text") {
                Text("Sample Text")
            }
            
            SectionView(
                title: "TextField",
                description: "An editable text that user can type") {
                TextField("Placeholder", text: $text)
            }
            
            SectionView(
                title: "SecureField",
                description: "Basically used for password") {
                SecureField("Password", text: $password)
            }
            
            SectionView(
                title: "TextEditor",
                description: "Editable long-form text") {
                TextEditor(text: $textEditor)
            }
        }
    }
}
