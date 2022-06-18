//
//  SettingsAboutView.swift
//  SwiftMos
//
//  Created by Zhuo FENG on 2022/6/18.
//

import SwiftUI

struct SettingsAboutView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("SwiftMos")
                    .font(.system(size: 64))
                    .fontWeight(.ultraLight)
                Spacer()
                Text("🐱")
                    .font(.system(size: 64))
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("c.slogan")
                    .font(.title3)
                
                Text("c.description")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 4)
            }
            .padding(.top, 8)
            
            HStack {
                Button("GitHub") {
                    NSWorkspace.shared.open(URL(string: "https://github.com/fenprace/SwiftMos")!)
                }
            }
            .padding(.top, 16)
        }
        .padding()
    }
}

struct SettingsAboutView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAboutView()
            .frame(width: 480)
    }
}
