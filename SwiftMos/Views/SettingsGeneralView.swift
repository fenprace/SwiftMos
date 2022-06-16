//
//  SettingsGeneralView.swift
//  SwiftMos
//
//  Created by Zhuo FENG on 2022/6/15.
//

import SwiftUI

struct SettingsGeneralView: View {
    @EnvironmentObject var pref: Preferences
    
    var body: some View {
        Form {
            Toggle("Enable Smooth", isOn: $pref.enableSmooth)
            Toggle("Enable Reverse X", isOn: $pref.enableReverseX)
            Toggle("Enable Reverse Y", isOn: $pref.enableReverseY)
        }
    }
}

struct SettingsAdvancedView: View {
    @EnvironmentObject var pref: Preferences
    
    var body: some View {
        Form {
            HStack {
                Slider(value: $pref.speed, in: 10...100, label: {
                    Text("Speed")
                })
                
                Stepper("", value: $pref.speed, in: 10...100, step: 0.01)
            }
            
            
            HStack {
                Slider(value: $pref.step, in: 1...10, label: {
                    Text("Step")
                })
                
                Stepper("", value: $pref.step, in: 1...10, step: 0.01)
            }
            
            HStack {
                Slider(value: $pref.duration, in: 1...5, label: {
                    Text("Duration")
                })
                
                Stepper("", value: $pref.duration, in: 1...5, step: 0.01)
            }
        }
        .padding()
    }
}
