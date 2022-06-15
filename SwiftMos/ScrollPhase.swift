//
//  ScrollPhase.swift
//  Mos
//
//  Created by 陈标 on 2020/12/19.
//  Copyright © 2020 Caldis. All rights reserved.
//

import Foundation

enum Phase {
    case Idle
    case Contact
    case Tracing
    case Momentum
    case PauseAuto
    case PauseManual
}
enum PhaseItem {
    case Scroll
    case Momentum
}

let PhaseValueMapping: [Phase: [PhaseItem: Double]] = [
    // 空
    Phase.Idle: [PhaseItem.Scroll: 0.0, PhaseItem.Momentum: 0.0],
    // 手指触碰
    Phase.Contact: [PhaseItem.Scroll: 128.0, PhaseItem.Momentum: 0.0],
    // 跟随滚动
    Phase.Tracing: [PhaseItem.Scroll: 2.0, PhaseItem.Momentum: 0.0],
    // 缓动
    Phase.Momentum: [PhaseItem.Scroll: 0.0, PhaseItem.Momentum: 2.0],
    // 缓动停止 (自动, 如缓动到达临界值)
    Phase.PauseAuto: [PhaseItem.Scroll: 0.0, PhaseItem.Momentum: 3.0],
    // 缓动停止 (手动)
    Phase.PauseManual: [PhaseItem.Scroll: 4.0, PhaseItem.Momentum: 0.0],
]

class ScrollPhase {
    
    // 单例
    static let shared = ScrollPhase()
    init() { NSLog("Module initialized: ScrollPhase") }
    
    var phase: Phase = Phase.Idle
    
    // MARK: - 滚动阶段更新
    let debounceSetPhaseToMomentum = Utils.debounce(delay: 200) {
        ScrollPhase.shared.phase = Phase.Momentum
    }
    func syncPhase() {
        if [Phase.Idle, Phase.Momentum, Phase.PauseAuto, Phase.PauseManual].contains(phase) {
            phase = Phase.Contact
        } else if (phase == Phase.Tracing) {
            phase = Phase.Tracing
        }
        debounceSetPhaseToMomentum()
    }
    
    // MARK: - 滚动阶段递进
    func consume() -> Phase {
        switch phase {
        case Phase.Idle:
            return Phase.Idle
        case Phase.Contact:
            phase = Phase.Tracing
            return Phase.Contact
        case Phase.Tracing:
            return Phase.Tracing
        case Phase.Momentum:
            return Phase.Momentum
        case Phase.PauseAuto:
            phase = Phase.Idle
            return Phase.PauseAuto
        case Phase.PauseManual:
            phase = Phase.Idle
            return Phase.PauseManual
        }
    }
    
    // MARK: - 滚动数据附加
    func attach(to event: CGEvent) {
        let prevPhase = ScrollPhase.shared.consume()
        // 仅作用于 Y 轴事件 (For MX Master)
        if event.getDoubleValueField(.scrollWheelEventPointDeltaAxis2) == 0.0 {
            if prevPhase == Phase.PauseAuto || prevPhase == Phase.PauseManual  {
                // 只有 Phase.PauseManual 对应的 [4.0, 0.0] 可以正确使 Chrome 恢复
                if let validPhaseValue = PhaseValueMapping[Phase.PauseManual] {
                    event.setDoubleValueField(.scrollWheelEventScrollPhase, value: validPhaseValue[PhaseItem.Scroll]!)
                    event.setDoubleValueField(.scrollWheelEventMomentumPhase, value: validPhaseValue[PhaseItem.Momentum]!)
                }
            }
        }
    }
}
