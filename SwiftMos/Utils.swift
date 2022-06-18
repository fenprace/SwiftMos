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
    
    // 匹配字符
    class func extractRegexMatches(target: String = "", pattern: String) -> String {
        do {
            let pattern = #"\/?.*\.app"#
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let range = NSRange(location: 0, length: target.count)
            let result = regex.firstMatch(in: target, options: [], range: range)
            if let validResult = result {
                return NSString(string: target).substring(with: validResult.range) as String
            } else {
                return target
            }
        } catch {
            return target
        }
    }
    
    // 移除字符
    class func removingRegexMatches(target: String = "", pattern: String, replaceWith: String = "") -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let range = NSRange(location: 0, length: target.count)
            return regex.stringByReplacingMatches(in: target, options: [], range: range, withTemplate: replaceWith)
        } catch {
            return target
        }
    }
    
    // 从路径获取应用图标
    class func getApplicationIcon(fromPath path: String?) -> NSImage {
          guard let validPath = path else {
              return NSWorkspace.shared.icon(forFile: "")
          }
          // 尝试完整路径对应的 Bundle 获取
          if let validBundle = Bundle.init(url: URL.init(fileURLWithPath: validPath)) {
              return NSWorkspace.shared.icon(forFile: validBundle.bundlePath)
          }
          // 尝试从子路径对应的 Bundle 获取
          let subPath = extractRegexMatches(target: validPath, pattern: #"\/?.*\.app"#)
          if let validBundle = Bundle.init(url: URL.init(fileURLWithPath: subPath)) {
              return NSWorkspace.shared.icon(forFile: validBundle.bundlePath)
          }
          // 从 Path 关联的 Bundle 获取
          return NSWorkspace.shared.icon(forFile: validPath)
      }
    
    // 从路径获取应用名称
    class func getAppliactionName(fromPath path: String?) -> String {
        guard let validPath = path else {
          return "Invalid Name"
        }
        
        // 尝试完整路径对应的 Bundle 获取
        if let validBundle = Bundle.init(url: URL.init(fileURLWithPath: validPath)) {
            return (
              validBundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
              validBundle.object(forInfoDictionaryKey: "CFBundleName") as? String ??
              parseName(fromPath: validPath)
            )
        }
        
        // 尝试从子路径对应的 Bundle 获取
        let subPath = extractRegexMatches(target: validPath, pattern: #"\/?.*\.app"#)
        if let validBundle = Bundle.init(url: URL.init(fileURLWithPath: subPath)) {
            return (
              validBundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
              validBundle.object(forInfoDictionaryKey: "CFBundleName") as? String ??
              parseName(fromPath: validPath)
            )
        }
        
        return parseName(fromPath: validPath)
    }
    
    class func parseName(fromPath path: String) -> String {
        let applicationRawName = FileManager().displayName(atPath: path).removingPercentEncoding!
        return Utils.removingRegexMatches(target: applicationRawName, pattern: ".app")
    }
}

