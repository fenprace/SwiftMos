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
            Toggle("Enable Reverse", isOn: $pref.enableReverse)
        }
    }
}

struct SettingsAdvancedView: View {
    @State private var enableSmooth: Bool = false
    
    var body: some View {
        Form {
            Toggle("Enable Smooth", isOn: $enableSmooth)
        }
    }
}
