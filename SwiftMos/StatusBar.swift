//
//  StatusBarController.swift
//  SwiftMos
//
//  Created by Zhuo FENG on 2022/6/16.
//

import Foundation
import AppKit

class StatusBar {
    private let statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    init() {
        statusBarItem.button?.title = "🐱"
        
        let menu = NSMenu()
        statusBarItem.menu = menu
        
        let menuItemPreferences = NSMenuItem()
        let menuItemQuit = NSMenuItem()
        
        menu.addItem(menuItemPreferences)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(menuItemQuit)

        menuItemPreferences.title = NSLocalizedString("c.preferences", comment: "preferences")
        menuItemPreferences.image = NSImage(
            systemSymbolName: "gear",
            accessibilityDescription: menuItemPreferences.title
        )
        menuItemPreferences.target = self
        menuItemPreferences.action = #selector(StatusBar.showPreferences)
        
        menuItemQuit.title = NSLocalizedString("c.quit", comment: "quit")
        menuItemQuit.image = NSImage(
            systemSymbolName: "escape",
            accessibilityDescription: menuItemQuit.title
        )
        menuItemQuit.target = self
        menuItemQuit.action = #selector(StatusBar.quit)
    }
    
    @objc func showPreferences() {
        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
        
        // 获取焦点
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @objc func quit() {
        NSApp.terminate(nil)
    }
}
