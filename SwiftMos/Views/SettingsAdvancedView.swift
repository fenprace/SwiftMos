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
                HStack(alignment: .firstTextBaseline) {
                    Text("c.step:").frame(width: 80, alignment: .trailing)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Slider(value: $pref.step, in: 10...100)
                                .labelsHidden()
                                .frame(width: 240)
                            Stepper(String(format: "%.2f", pref.step), value: $pref.step, in: 10...100, step: 0.01)
                                .frame(width: 80, alignment: .trailing)
                        }
                        
                        Text("c.step.desc")
                            .foregroundColor(.secondary).font(.system(size: 12))
                    }
                }
                
                HStack(alignment: .firstTextBaseline) {
                    Text("c.speed:").frame(width: 80, alignment: .trailing)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Slider(value: $pref.speed, in: 1...10)
                                .labelsHidden()
                                .frame(width: 240)
                            Stepper(String(format: "%.2f", pref.speed), value: $pref.speed, in: 1...10, step: 0.01)
                                .frame(width: 80, alignment: .trailing)
                        }
                        
                        Text("c.speed.desc")
                            .foregroundColor(.secondary).font(.system(size: 12))
                    }
                }
                
                HStack(alignment: .firstTextBaseline) {
                    Text("c.duration:").frame(width: 80, alignment: .trailing)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Slider(value: $pref.duration, in: 1...5)
                                .labelsHidden()
                                .frame(width: 240)
                            Stepper(String(format: "%.2f", pref.duration), value: $pref.duration, in: 1...5, step: 0.01)
                                .frame(width: 80, alignment: .trailing)
                        }
                        
                        Text("c.duration.desc")
                            .foregroundColor(.secondary).font(.system(size: 12))
                    }
                }
            }
            
            Button("c.reset") {
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
