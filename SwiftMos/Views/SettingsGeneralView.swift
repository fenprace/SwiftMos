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
        HStack(alignment: .firstTextBaseline) {
            Text("c.scroll:")
            
            Form {
                Toggle("c.enableScroll", isOn: $pref.enableSmooth).foregroundColor(.primary)
                Text("c.enableScroll.desc")
                    .foregroundColor(.secondary).font(.system(size: 12))
                
                Toggle("c.enableReverseX", isOn: $pref.enableReverseX)
                Text("c.enableReverseX.desc")
                    .foregroundColor(.secondary).font(.system(size: 12))
                
                Toggle("c.enableReverseY", isOn: $pref.enableReverseY)
                Text("c.enableReverseY.desc")
                    .foregroundColor(.secondary).font(.system(size: 12))
            }
        }
        .padding()
    }
}

struct SettingsGeneralView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsGeneralView().environmentObject(Preferences.shared)
    }
}
