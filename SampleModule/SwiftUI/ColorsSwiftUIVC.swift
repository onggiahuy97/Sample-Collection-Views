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

struct ColorsView: View {
    
    struct BasicColor {
        var id = UUID()
        var name: String
        var color: Color
    }
    
    var colors = [
        BasicColor(name: "accentColor", color: .accentColor),
        BasicColor(name: "black", color: .black),
        BasicColor(name: "blue", color: .blue),
        BasicColor(name: "clear", color: .clear),
        BasicColor(name: "gray", color: .gray),
        BasicColor(name: "green", color: .green),
        BasicColor(name: "orange", color: .orange),
        BasicColor(name: "pink", color: .pink),
        BasicColor(name: "primary", color: .primary),
        BasicColor(name: "purple", color: .purple),
        BasicColor(name: "red", color: .red),
        BasicColor(name: "secondary", color: .secondary),
        BasicColor(name: "white", color: .white),
        BasicColor(name: "yellow", color: .yellow)
    ]
    
    var body: some View {
        Form {
            ForEach(colors, id: \.id) { color in
                SampleColor(color: color)
            }
        }
    }
    
    struct SampleColor: View {
        var color: BasicColor
        var body: some View {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(color.color)
                    .frame(width: 24, height: 24)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color("StrokeColor"), lineWidth: 1)
                    )
                Text(color.name)
                Spacer()
            }
        }
    }
}
