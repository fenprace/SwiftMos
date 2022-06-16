//
//  SettingsView.swift
//  SwiftMos
//
//  Created by Zhuo FENG on 2022/6/15.
//

import SwiftUI

struct SettingsView: View {
    private enum Tabs: Hashable {
        case general
        case advanced
    }
    
    var body: some View {
        TabView {
            SettingsGeneralView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
                .environmentObject(Preferences.shared)
            
            SettingsAdvancedView()
                .tabItem {
                    Label("Advanced", systemImage: "cpu")
                }
                .tag(Tabs.advanced)
                .environmentObject(Preferences.shared)
        }
        .frame(width: 480, height: 360)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
