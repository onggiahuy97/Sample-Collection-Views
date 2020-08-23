//
//  ContentView.swift
//  SampleModule
//
//  Created by Huy Ong on 8/21/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CombineCollectionViewContainer()
                .edgesIgnoringSafeArea(.all)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
