//
//  ContentView.swift
//  SampleModule
//
//  Created by Huy Ong on 8/21/20.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tag = .ui

    var body: some View {
        TabView(selection: $selection) {
            CombineCollectionViewContainer()
                .edgesIgnoringSafeArea(.all)
                .tabItem {
                    Image(systemName: selection == .ui ? "greetingcard.fill" : "greetingcard")
                    Text("UI")
                }
                .tag(Tag.ui)
            
            Text("Data coming soon...\n Save/Read/Write Data in CoreData/FileManager/Bundle")
                .tabItem {
                    Image(systemName: selection == .data ? "icloud.fill" : "icloud")
                    Text("Data")
                }
                .tag(Tag.data)
            
            Text("Network coming soon...")
                .tabItem {
                    Image(systemName: "dot.radiowaves.left.and.right")
                    Text("Network")
                }
                .tag(Tag.network)
            
        }
    }
}

extension ContentView {
    private enum Tag {
        case ui, data, network
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
