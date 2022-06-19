//
//  ScrollCore.swift
//  SwiftMos
//
//  Created by Zhuo FENG on 2022/6/15.
//

import Foundation

class ScrollCore {
    // MARK: - Constants
    let scrollEventMask = CGEventMask(1 << CGEventType.scrollWheel.rawValue)
    
    static let shared = ScrollCore()
    
    private var isActive = false
    
    private var scrollEventInterceptor: Interceptor? = nil
    
    var blockSmooth = false
    
    var dashAmplification = 1.0
    
    let scrollEventCallBack: CGEventTapCallBack = { (proxy, type, event, refcon) in
        // 滚动事件
        let scrollEvent = ScrollEvent(with: event)
        
        // 不处理触控板
        // 无法区分黑苹果, 因为黑苹果的触控板驱动直接模拟鼠标输入
        if scrollEvent.isTrackpad() { return Unmanaged.passUnretained(event) }
        
        // 切换目标窗时停止滚动
        if ScrollUtils.shared.isTargetChanged(event) {
            ScrollPoster.shared.pauseAuto()
            return nil
        }
        
        // 滚动阶段
        ScrollPhase.shared.syncPhase()
        
        // 当鼠标输入, 根据需要执行翻转方向/平滑滚动
        // 获取事件目标
        let targetRunningApplication = ScrollUtils.shared.getRunningApplication(from: event)
        
        // 平滑/翻转
        var enableSmooth = Preferences.shared.enableSmooth && !ScrollCore.shared.blockSmooth
        var enableReverseX = Preferences.shared.enableReverseX
        var enableReverseY = Preferences.shared.enableReverseY
        
        var step = Preferences.shared.step
        var speed = Preferences.shared.speed
        var duration = Preferences.shared.durationTransition
        
        // Launchpad 激活则强制屏蔽平滑
        if ScrollUtils.shared.getLaunchpadActivity(withRunningApplication: targetRunningApplication) {
            enableSmooth = false
        }
        
        // 是否返回原始事件 (不启用平滑时)
        // 平滑滚动时禁止返回原始事件
        var returnOriginalEvent = !(enableSmooth && (scrollEvent.X.valid || scrollEvent.Y.valid))
        
        // Y轴
        if scrollEvent.Y.valid {
            // 是否翻转滚动
            if enableReverseY {
                ScrollEvent.reverseY(scrollEvent)
            }
            
            // 是否平滑滚动
            if enableSmooth {
                // 如果输入值为非 Fixed 类型, 则使用 Step 作为门限值将数据归一化
                if !scrollEvent.Y.fixed {
                    ScrollEvent.normalizeY(scrollEvent, step)
                }
            }
        }
        
        // X轴
        if scrollEvent.X.valid {
            // 是否翻转滚动
            if enableReverseX {
                ScrollEvent.reverseX(scrollEvent)
            }
            
            // 是否平滑滚动
            if enableSmooth {
                // 如果输入值为非 Fixed 类型, 则使用 Step 作为门限值将数据归一化
                if !scrollEvent.X.fixed {
                    ScrollEvent.normalizeX(scrollEvent, step)
                }
            }
        }
        
        // 触发滚动事件推送
        if enableSmooth {
            ScrollPoster.shared.update(
                event: event,
                proxy: proxy,
                duration: duration,
                y: scrollEvent.Y.usableValue,
                x: scrollEvent.X.usableValue,
                speed: speed,
                amplification: ScrollCore.shared.dashAmplification
            ).enable()
        }
        
        // 返回事件对象
        if returnOriginalEvent {
            return Unmanaged.passUnretained(event)
        } else {
            return nil
        }
    }
    
    func startHandlingScroll() {
        // Guard
        if isActive { return }
        isActive = true
        
        // 截取事件
        scrollEventInterceptor = Interceptor(
            event: scrollEventMask,
            handleBy: scrollEventCallBack,
            listenOn: .cgAnnotatedSessionEventTap,
            placeAt: .tailAppendEventTap,
            for: .defaultTap
        )
        
        // 初始化滚动事件发送器
        ScrollPoster.shared.create()
    }
    
    func endHandlingScroll() {
        // Guard
        if !isActive { return }
        isActive = false
        
        // 停止滚动事件发送器
        ScrollPoster.shared.disableAuto()
        
        // 停止截取事件
        scrollEventInterceptor?.stop()
    }
}
