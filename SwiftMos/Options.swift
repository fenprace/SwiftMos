//
//  Options.swift
//  SwiftMos
//
//  Created by Zhuo FENG on 2022/6/15.
//

import Foundation
import SwiftUI

class OPTIONS_GENERAL_DEFAULT {
    var autoLaunch = false
    var hideStatusItem = false
    var whitelist = false
}

class OPTIONS_SCROLL_BASIC_DEFAULT: Codable {
    var smooth = true
    var reverse = true
}

class OPTIONS_SCROLL_ADVANCED_DEFAULT: Codable {
    var dash:Int? = 0 {
        didSet { Options.shared.saveOptions() }
    }
    var toggle:Int? = 0 {
        didSet { Options.shared.saveOptions() }
    }
    var block:Int? = 0 {
        didSet {Options.shared.saveOptions()}
    }
    var step = 35.0 {
        didSet {Options.shared.saveOptions()}
    }
    var speed = 3.00 {
        didSet {Options.shared.saveOptions()}
    }
    var duration = 3.90 {
        willSet {self.durationTransition = OPTIONS_SCROLL_ADVANCED_DEFAULT.generateDurationTransition(with: newValue)}
        didSet {Options.shared.saveOptions()}
    }
    var durationTransition = 0.1340 {
        didSet {}
    }
    var precision = 1.00 {
        didSet {Options.shared.saveOptions()}
    }
    
    // 工具
    static func generateDurationTransition(with duration: Double) -> Double {
        // 上界, 此处需要与界面的 Slider 上界保持同步, 并添加 0.2 的偏移令结果不为 0
        let upperLimit = 5.0 + 0.2
        // 生成数据 (https://www.wolframalpha.com/input/?i=1+-+(sqrt+x%2F5)+%3D+y)
        let val = 1-(duration/upperLimit).squareRoot()
        // 三位小数
        return Double(round(1000 * val)/1000)
    }
}

extension OPTIONS_SCROLL_ADVANCED_DEFAULT: Equatable {
    static func == (l: OPTIONS_SCROLL_ADVANCED_DEFAULT, r: OPTIONS_SCROLL_ADVANCED_DEFAULT) -> Bool {
        return (
            l.dash == r.dash &&
            l.toggle == r.toggle &&
            l.block == r.block &&
            l.step == r.step &&
            l.speed == r.speed &&
            l.duration == r.duration &&
            l.durationTransition == r.durationTransition &&
            l.precision == r.precision
        )
    }
}

class Options {
    static let shared = Options()
    
    var general = OPTIONS_GENERAL_DEFAULT()
    var scrollBasic = OPTIONS_SCROLL_BASIC_DEFAULT()
    var scrollAdvanced = OPTIONS_SCROLL_ADVANCED_DEFAULT() {
        didSet { Options.shared.saveOptions() }
    }
    
    func readOptions() {
        print("Reading Options")
    }
    
    func saveOptions() {
        
    }
}
