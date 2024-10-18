//
//  TimeDisplaying.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/17/24.
//

protocol TimeDisplaying {
    var subHourFormat: String { get }
    var hourPlusFormat: String { get }
    var timeDisplayed: String { get }
    var timerStateManager: TimerStateManager { get }
    var timerType: TimerType { get }
    var timeKeeper: Int { get }
}

extension TimeDisplaying {
    var subHourFormat: String { "%02d:%02d" }
    var hourPlusFormat: String { "%i:%02d:%02d" }
    var timeKeeper: Int {
        switch timerType {
            case .currentTimer:
                timerStateManager.totalSeconds
            case .roundTimer:
                timerStateManager.roundTime
            case .restTimer:
                timerStateManager.restTime
        }
    }

    var timeDisplayed: String {
        let hours = timeKeeper / 3600
        let minutes = (timeKeeper % 3600) / 60
        let seconds = timeKeeper % 60
        if hours < 1 {
            return String(format: subHourFormat, minutes, seconds)
        } else {
            return String(format: hourPlusFormat, hours, minutes, seconds)
        }
    }
}

enum TimerType {
    case currentTimer
    case roundTimer
    case restTimer
}
