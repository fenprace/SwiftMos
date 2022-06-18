//
//  SettingsAdvancedView.swift
//  SwiftMos
//
//  Created by Zhuo FENG on 2022/6/17.
//

import Foundation
import SwiftUI

struct SettingsAdvancedView: View {
    @EnvironmentObject var pref: Preferences
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Slider(value: $pref.step, in: 10...100) {
                        Text("Step").frame(width: 80, alignment: .trailing)
                    }
                        .frame(width: 320)
                    Stepper(String(format: "%.2f", pref.step), value: $pref.step, in: 10...100, step: 0.01)
                        .frame(width: 80, alignment: .trailing)
                }
                
                
                HStack {
                    Slider(value: $pref.speed, in: 1...10) {
                        Text("Speed").frame(width: 80, alignment: .trailing)
                    }
                        .frame(width: 320)
                    
                    Stepper(String(format: "%.2f", pref.speed), value: $pref.speed, in: 1...10, step: 0.01)
                        .frame(width: 80, alignment: .trailing)
                        
                }
                
                HStack {
                    Slider(value: $pref.duration, in: 1...5) {
                        Text("Duration").frame(width: 80, alignment: .trailing)
                    }
                        .frame(width: 320)
                    
                    Stepper(String(format: "%.2f", pref.duration), value: $pref.duration, in: 1...5, step: 0.01)
                        .frame(width: 80, alignment: .trailing)
                }
            }
            
            Button("Reset") {
                Preferences.shared.resetAdvanced()
            }
        }.padding()
    }
}

struct SettingsAdvancedView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAdvancedView()
            .environmentObject(Preferences.shared)
    }
}
