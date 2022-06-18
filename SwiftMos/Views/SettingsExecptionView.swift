//
//  SettingsExecptionView.swift
//  SwiftMos
//
//  Created by Zhuo FENG on 2022/6/18.
//

import Foundation
import SwiftUI

struct Person: Identifiable {
    let givenName: String
    let familyName: String
    let emailAddress: String
    let id = UUID()
}

struct SettingsExceptionView: View {
    @EnvironmentObject var pref: Preferences
    
    private var people = [
        Person(givenName: "Juan", familyName: "Chavez", emailAddress: "juanchavez@icloud.com"),
        Person(givenName: "Mei", familyName: "Chen", emailAddress: "meichen@icloud.com"),
        Person(givenName: "Tom", familyName: "Clark", emailAddress: "tomclark@icloud.com"),
        Person(givenName: "Gita", familyName: "Kumar", emailAddress: "gitakumar@icloud.com")
    ]
    
    var body: some View {
        
        VStack {
            Table(people) {
                TableColumn("Given Name") { row in
                    Toggle("", isOn: .constant(false))
                        .labelsHidden()
                    
                }
                TableColumn("Family Name", value: \.familyName)
                TableColumn("E-Mail Address", value: \.emailAddress)
            }
            
            HStack {
                Button(action: {}, label: { Image(systemName: "plus") })
                Button(action: {}, label: { Image(systemName: "minus") })
            }
            
        }.padding()
    }
}

struct SettingsExceptionView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsExceptionView().environmentObject(Preferences.shared)
    }
}
