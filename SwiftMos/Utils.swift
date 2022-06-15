//
//  Utils.swift
//  SwiftMos
//
//  Created by Zhuo FENG on 2022/6/15.
//

import Foundation
import Cocoa
import SwiftUI

class Utils {
    static func preventMultiRunning(killExist: Bool) {
        
    }
    
    // 辅助功能权限相关
    // 来源: http://see.sl088.com/wiki/Mac%E5%BC%80%E5%8F%91_%E8%BE%85%E5%8A%A9%E5%8A%9F%E8%83%BD%E6%9D%83%E9%99%90
    // 查询是否有辅助功能权限
    static func isHadAccessibilityPermissions() -> Bool {
        let hasPerm = AXIsProcessTrusted()
        print("hasPerm: \(hasPerm)")
        return hasPerm
    }
    
    static func debounce(delay: Int, action: @escaping (() -> Void)) -> () -> Void {
        var lastFireTime = DispatchTime.now()
        let dispatchDelay = DispatchTimeInterval.milliseconds(delay)

        return {
            lastFireTime = DispatchTime.now()
            let dispatchTime: DispatchTime = DispatchTime.now() + dispatchDelay
            DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
                let when: DispatchTime = lastFireTime + dispatchDelay
                let now = DispatchTime.now()
                if now.rawValue >= when.rawValue {
                    action()
                }
            }
        }
    }
    
    static var runningApplicationThreshold = 60.0
    static var runningApplicationCache = [String: NSRunningApplication]()
    static var runningApplicationDetectTime = [String: Double]()
    static func getRunningApplicationProcessIdentifier(withBundleIdentifier bundleIdentifier: String) -> NSRunningApplication? {
        let now = NSDate().timeIntervalSince1970
        if now - (runningApplicationDetectTime[bundleIdentifier] ?? 0.0) > runningApplicationThreshold {
            let runningApplications = NSRunningApplication.runningApplications(withBundleIdentifier: bundleIdentifier)
            runningApplicationCache[bundleIdentifier] = runningApplications.count > 0 ? runningApplications[0] : nil
            runningApplicationDetectTime[bundleIdentifier] = now
        }
        return runningApplicationCache[bundleIdentifier] ?? nil
    }
}

