//
//  ContentView.swift
//  SampleModule
//
//  Created by Huy Ong on 8/21/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            CombineCollectionViewContainer()
                .edgesIgnoringSafeArea(.all)
                .navigationTitle("Sample Collection Views")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
