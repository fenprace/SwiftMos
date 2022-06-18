//
//  ExceptionalApplication.swift
//  SwiftMos
//
//  Created by Zhuo FENG on 2022/6/15.
//

import Cocoa

class ExceptionalApplication: Codable, Equatable {

    // 基础
    var path: String // executablePath or bundlePath
    
    // 配置: 名称
    var displayName: String? = ""
    
    // 配置: 继承 (仅包含 Advanced 部分)
    var inherit = true
    
    // 配置: 滚动
    var enableScroll = false
    var enableReverseX = false
    var enableReverseY = false
    
//    var scrollAdvanced = OPTIONS_SCROLL_ADVANCED_DEFAULT() {
//        didSet {Options.shared.saveOptions()}
//    }
    
    // 初始化
    init(path: String) {
        self.path = path
    }
    
    // Codable
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        // 基础
//        path = try container.decodeIfPresent(String.self, forKey: .path) ?? ""
//        // 名称
//        displayName = try container.decodeIfPresent(String.self, forKey: .displayName) ?? ""
//        // 继承
//        inherit = try container.decodeIfPresent(Bool.self, forKey: .inherit) ?? true
//        // 滚动
//        enableScroll = try container.decodeIfPresent(Bool.self, forKey: .enableScroll) ?? false
//        enableReverseX = try container.decodeIfPresent(Bool.self, forKey: .enableReverseX) ?? false
//        enableReverseY = try container.decodeIfPresent(Bool.self, forKey: .enableReverseY) ?? false
//
//        // scrollAdvanced = try container.decodeIfPresent(OPTIONS_SCROLL_ADVANCED_DEFAULT.self, forKey: .scrollAdvanced) ?? OPTIONS_SCROLL_ADVANCED_DEFAULT()
//    }
    
    // Equatable
    static func == (a: ExceptionalApplication, b: ExceptionalApplication) -> Bool {
        return a.path == b.path
    }
}

/**
 * 工具函数
 */
extension ExceptionalApplication {
    // 基本信息
    func getIcon() -> NSImage {
        return Utils.getApplicationIcon(fromPath: path)
    }
    
    func getName() -> String {
        if let name = displayName, name.count > 0 {
            return name
        }
        return Utils.getAppliactionName(fromPath: path)
    }

    // 配置
//    func getStep() -> Double {
//        return inherit ? Options.shared.scrollAdvanced.step : scrollAdvanced.step
//    }
//    func getSpeed() -> Double {
//        return inherit ? Options.shared.scrollAdvanced.speed : scrollAdvanced.speed
//    }
//    func getDuration() -> Double {
//        return inherit ? Options.shared.scrollAdvanced.durationTransition : scrollAdvanced.durationTransition
//    }
    
    // 功能
    func isSmooth(_ block: Bool) -> Bool {
        if block { return false }
        
        if !Preferences.shared.enableSmooth { return false }
        return enableScroll
    }
    
    func isReverseX() -> Bool {
        if !Preferences.shared.enableReverseX { return false }
        return enableReverseX
    }
    
    func isReverseY() -> Bool {
        if !Preferences.shared.enableReverseY { return false }
        return enableReverseY
    }
}
