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

        menuItemPreferences.title = "Preferences"
        menuItemPreferences.image = NSImage(systemSymbolName: "gear", accessibilityDescription: "Preferences")
        menuItemPreferences.target = self
        menuItemPreferences.action = #selector(StatusBar.showPreferences)
        
        menuItemQuit.title = "Quit"
        menuItemQuit.image = NSImage(systemSymbolName: "escape", accessibilityDescription: "Quit")
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
