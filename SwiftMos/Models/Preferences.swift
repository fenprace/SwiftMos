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
    
    @Published var enableReverseX: Bool = true {
        didSet {
            UserDefaults.standard.set(enableReverseX, forKey: "enableReverseX")
        }
    }
    
    @Published var enableReverseY: Bool = true {
        didSet {
            UserDefaults.standard.set(enableReverseY, forKey: "enableReverseY")
        }
    }
    
    @Published var step: Double = 35.0 {
        didSet {
            print(step)
            UserDefaults.standard.set(step, forKey: "step")
        }
    }
    
    @Published var speed: Double = 3.0 {
        didSet {
            print(speed)
            UserDefaults.standard.set(speed, forKey: "speed")
        }
    }
    
    @Published var durationTransition: Double = 0.1340
    @Published var duration: Double = 3.9 {
        willSet {
            self.durationTransition = Preferences.generateDurationTransition(with: newValue)
        }
        
        didSet {
            UserDefaults.standard.set(duration, forKey: "duration")
        }
    }
    
    @Published var applications: [ExceptionalApplication] = [] {
        didSet {
            let encoder = JSONEncoder()
            
            do {
                let encoded = try encoder.encode(applications)
                UserDefaults.standard.set(encoded, forKey: "applications")
            } catch {
                
            }
        }
    }
    
    var precision = 1.00 {
        didSet {
            UserDefaults.standard.set(precision, forKey: "precision")
        }
    }

    init() {
        self.enableSmooth = UserDefaults.standard.bool(forKey: "enableSmooth")
        self.enableReverseX = UserDefaults.standard.bool(forKey: "enableReverseX")
        self.enableReverseY = UserDefaults.standard.bool(forKey: "enableReverseY")
        self.step = UserDefaults.standard.double(forKey: "step")
        self.speed = UserDefaults.standard.double(forKey: "speed")
        self.duration = UserDefaults.standard.double(forKey: "duration")
        self.precision = UserDefaults.standard.double(forKey: "precision")
        
        if let data = UserDefaults.standard.data(forKey: "applications") {
            let decoder = JSONDecoder()
            
            do {
                self.applications = try decoder.decode([ExceptionalApplication].self, from: data)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        
    }
    
    static func generateDurationTransition(with duration: Double) -> Double {
        // 上界, 此处需要与界面的 Slider 上界保持同步, 并添加 0.2 的偏移令结果不为 0
        let upperLimit = 5.0 + 0.2
        // 生成数据 (https://www.wolframalpha.com/input/?i=1+-+(sqrt+x%2F5)+%3D+y)
        let val = 1 - (duration / upperLimit).squareRoot()
        // 三位小数
        return Double(round(1000 * val) / 1000)
    }
    
    func resetAdvanced() {
        self.step = 35.0
        self.speed = 3.0
        self.duration = 3.9
    }
}
