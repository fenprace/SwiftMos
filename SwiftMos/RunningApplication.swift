//
//  RunningApplication.swift
//  SwiftMos
//
//  Created by Zhuo FENG on 2022/6/18.
//

import Foundation
import AppKit

class RunningApplication {
    static var runningApplicationThreshold = 60.0
    static var runningApplicationCache = [String: NSRunningApplication]()
    static var runningApplicationDetectTime = [String: Double]()
    
    static func getProcessIdentifier(withBundleIdentifier bundleIdentifier: String) -> NSRunningApplication? {
        let now = NSDate().timeIntervalSince1970
        if now - (runningApplicationDetectTime[bundleIdentifier] ?? 0.0) > runningApplicationThreshold {
            let runningApplications = NSRunningApplication.runningApplications(withBundleIdentifier: bundleIdentifier)
            runningApplicationCache[bundleIdentifier] = runningApplications.count > 0 ? runningApplications[0] : nil
            runningApplicationDetectTime[bundleIdentifier] = now
        }
        return runningApplicationCache[bundleIdentifier] ?? nil
    }
}
