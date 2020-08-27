//
//  HapticsViewController.swift
//  SampleModule
//
//  Created by Huy Ong on 8/25/20.
//

import SwiftUI

class HapticsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Haptics"
        let aView = UIHostingController(rootView: HapticsView())
        view.addSubview(aView.view)
        aView.view.frame = view.bounds
    }
}

struct HapticsView: View {
    var body: some View {
        Form {
            SectionView(title: "UIImpactFeedbackGenerator",
                        description: "Haptic feedback provides a tactile response.") {
                Group {
                    Button(action: { playFeedbackHaptic(.heavy) }) {
                        Text("heavy")
                    }
                    
                    Button(action: { playFeedbackHaptic(.light) }) {
                        Text("light")
                    }
                    
                    Button(action: { playFeedbackHaptic(.medium) }) {
                        Text("medium")
                    }
                    
                    Button(action: { playFeedbackHaptic(.rigid) }) {
                        Text("rigid")
                    }
                    
                    Button(action: { playFeedbackHaptic(.soft) }) {
                        Text("soft")
                    }
                }
            }
            
            SectionView(title: "UINotificationFeedbackGenerator", description: "Communication for successes, failures, and warnings") {
                Group {
                    Button(action: { playNotificationHaptic(.error) }) {
                        Text("error")
                    }
                    
                    Button(action: { playNotificationHaptic(.success) }) {
                        Text("success")
                    }
                    
                    Button(action: { playNotificationHaptic(.warning) }) {
                        Text("warning")
                    }
                }
            }
        }
    }
    
    func playFeedbackHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    func playNotificationHaptic(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}
