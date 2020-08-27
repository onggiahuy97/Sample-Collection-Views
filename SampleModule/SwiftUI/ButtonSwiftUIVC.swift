//
//  ButtonSwiftUIVC.swift
//  SampleModule
//
//  Created by Huy Ong on 8/25/20.
//

import SwiftUI

class ButtonsSwiftUIVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Buttons"
        let aView = UIHostingController(rootView: ButtonsSwiftUIView())
        view.addSubview(aView.view)
        aView.view.frame = view.bounds
    }
}

struct ButtonsSwiftUIView: View {
    @State private var showingAlert = false
    @State private var showingSheet = false
    @State private var showingActionSheet = false
    
    var body: some View {
        Form {
            SectionView(title: "NavigationLink", description: "Push to a new view") {
                NavigationLink("Next", destination: Text("New View"))
            }
            
            SectionView(title: "Basic action buttons", description: "Tap to perform an action") {
                Group {
                    Button(action: { showingAlert = true }) {
                        Text("Show Alert")
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Alert!"),
                              message: Text("Test showing alert"),
                              dismissButton: .cancel())
                    }
                    
                    Button(action: { showingSheet = true }) {
                        Text("Show Sheet")
                    }
                    .sheet(isPresented: $showingSheet) {
                        Text("Test showing sheet")
                    }
                    
                    Button(action: { showingActionSheet = true }) {
                        Text("Show Action Sheet")
                    }
                    .actionSheet(isPresented: $showingActionSheet) {
                        ActionSheet(title: Text("Action Sheet"),
                                    message: Text("..."),
                                    buttons: [.cancel()])
                    }
                }
            }
            
            SectionView(title: "Link", description: "Navigate to a URL") {
                Link("Huy's Twitter", destination: URL(string: "https://twitter.com/OGHuy18")!)
            }
            
            SectionView(title: "Menu", description: "Menu of buttons") {
                HStack {
                    Text("Show Menu")
                    Spacer()
                    Text("Press & Hold").italic().foregroundColor(.secondary)
                }
                .contextMenu {
                    Button("Button") {}
                    Button("Button") {}
                    Button("Button") {}
                    Divider()
                    Button("Button") {}
                }
            }
            
            SectionView(title: "Sign in With Apple", description: "sign with Apple ID") {
                SignInWithAppleButton(.signIn) { (request) in
                    request.requestedScopes = [.fullName, .email]
                } onCompletion: { (_) in
                    
                }
                
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
