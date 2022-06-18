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
        .padding()
    }
}

struct SettingsGeneralView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsGeneralView().environmentObject(Preferences.shared)
    }
}
