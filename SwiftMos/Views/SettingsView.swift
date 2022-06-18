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
        case about
    }
    
    var body: some View {
        TabView {
            SettingsGeneralView()
                .tabItem {
                    Label("c.general", systemImage: "gear")
                }
                .tag(Tabs.general)
                .environmentObject(Preferences.shared)
            
            SettingsAdvancedView()
                .tabItem {
                    Label("c.advanced", systemImage: "cpu")
                }
                .tag(Tabs.advanced)
                .environmentObject(Preferences.shared)
            
            SettingsAboutView()
                .tabItem {
                    Label("c.about", systemImage: "person.crop.square")
                }
                .tag(Tabs.about)
        }
        .frame(width: 480)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
