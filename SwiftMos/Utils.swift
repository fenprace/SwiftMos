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
    // 禁止重复运行
    // killExist = true 则杀掉已有进程, 否则自杀
    class func preventMultiRunning(killExist kill: Bool = false) {
       // 自己的 BundleId
       let mainBundleID = Bundle.main.bundleIdentifier!
        
       // 如果检测到在运行
       if NSRunningApplication.runningApplications(withBundleIdentifier: mainBundleID).count > 1 {
           if kill {
               let runningInst = NSRunningApplication.runningApplications(withBundleIdentifier: mainBundleID)[0]
               runningInst.terminate()
               NSLog("Terminate: Other instance", runningInst.processIdentifier)
           } else {
               NSApp.terminate(nil)
               NSLog("Terminate: Suicide")
           }
       }
   }
    
    // 辅助功能权限相关
    // 来源: http://see.sl088.com/wiki/Mac%E5%BC%80%E5%8F%91_%E8%BE%85%E5%8A%A9%E5%8A%9F%E8%83%BD%E6%9D%83%E9%99%90
    // 查询是否有辅助功能权限
    static func isHadAccessibilityPermissions() -> Bool {
        let hasPerm = AXIsProcessTrusted()
        return hasPerm
    }
    
    // 从 Dock 隐藏
    static func hideFromDock() {
        NSApp.setActivationPolicy(.accessory)
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
}

