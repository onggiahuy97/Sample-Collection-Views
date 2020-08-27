//
//  SystemControlsSwiftUIVC.swift
//  SampleModule
//
//  Created by Huy Ong on 8/25/20.
//

import SwiftUI

class SystemControlsSwiftUIVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "System Controls"
        let aView = UIHostingController(rootView: SystemControlsView())
        view.addSubview(aView.view)
        aView.view.frame = view.bounds
    }
}

struct SystemControlsView: View {
    @State private var toggle = true
    @State private var vibrateOnSilent = true
    @State private var drink = Drink.coffee
    @State private var birthday = Date()
    @State private var alarm = Date()
    @State private var volume = 38.0
    @State private var step = 3.0
    @State private var number = 0
    @State private var color = Color(.black)
    
    enum Drink: String, CaseIterable, Identifiable {
        case coffee, tea, water
        
        var id: String { self.rawValue }
        var description: String { self.rawValue.localizedCapitalized }
    }
    
    var body: some View {
        Form {
            SectionView(title: "Toggle", description: "Switch between on and off") {
                Group {
                    Toggle("\(toggle ? "On 🟢" : "Off 🔴")", isOn: $toggle)
                }
            }
            
            SectionView(title: "Picker", description: "Different styles of pickers") {
                Group {
                    Picker("Drink", selection: $drink) {
                        ForEach(Drink.allCases) { Text($0.description).tag($0) }
                    }
                    
                    Picker("Drink", selection: $drink) {
                        ForEach(Drink.allCases) { Text($0.description).tag($0) }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker("Drink", selection: $drink) {
                        ForEach(Drink.allCases) { Text($0.description).tag($0) }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
            }
            
            SectionView(title: "DatePicker", description: "Pick a date") {
                Group {
                    DatePicker(selection: $birthday, in: ...Date(), displayedComponents: .date) {
                        Text("Birthday")
                    }
                    
                    DatePicker("Alarm", selection: $alarm, displayedComponents: .hourAndMinute)
                }
            }
            
            SectionView(title: "ColorPicker", description: "pick a color") {
                ColorPicker("Color", selection: $color)
            }
            
            SectionView(title: "Stepper", description: "perform semantic increment or decrement actions") {
                Stepper("Number: \(number)", value: $number, in: 0...10)
            }
            
            SectionView(title: "Slider", description: "linear sliders") {
                Group {
                    Slider(value: $volume, in: 0...100, minimumValueLabel: Text("0%"), maximumValueLabel: Text("100%")) {
                        Text("Volume")
                    }
                    
                    Slider(value: $step, in: 0...10, step: 1, minimumValueLabel: Text("0"), maximumValueLabel: Text("10"), label: { Text("Step") })
                }
            }
        }
    }
}

