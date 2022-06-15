//
//  Preferences.swift
//  SwiftMos
//
//  Created by Zhuo FENG on 2022/6/15.
//

import Foundation
import SwiftUI

class Preferences: ObservableObject {
    static var shared = Preferences()
    
    @Published var enableSmooth: Bool = true {
        didSet {
            UserDefaults.standard.set(enableSmooth, forKey: "enableSmooth")
        }
    }
    
    @Published var enableReverse: Bool = true {
        didSet {
            UserDefaults.standard.set(enableSmooth, forKey: "enableReverse")
        }
    }

    init() {
        self.enableSmooth = UserDefaults.standard.bool(forKey: "enableSmooth")
        self.enableReverse = UserDefaults.standard.bool(forKey: "enableReverse")
    }
}
