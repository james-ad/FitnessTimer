//
//  TimerStateManager.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/10/24.
//

import Combine
import SwiftUI

@Observable class TimerStateManager {
    var buttonTitle = String(localized: "START")
    var isFinished: Bool = false
    // Might need pause status later to distinguish between pause and stop
    var isPaused: Bool = false
    var isRunning: Bool = false

    var roundNumber: Int = 0
    var roundTime: Int = 0
    var restTime: Int = 0
    var totalRounds: Int = 0
    var totalSeconds: Int = 0

    var roundPickerTime = (seconds: 0, minutes: 0)
    var restPickerTime = (seconds: 0, minutes: 0)

    @ObservationIgnored private var cancellable: Cancellable?

    func startTimer() {
        cancellable = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.totalSeconds += 1
            }

        isRunning = true
        buttonTitle = String(localized: "PAUSE")
    }

    func stopTimer() {
        cancellable?.cancel()
        cancellable = nil
        isRunning = false
        buttonTitle = String(localized: "START")
    }

    func resetTimer() {
        totalSeconds = 0
    }

    func setTime(minutes: Int,
                 seconds: Int,
                 forTimerType timerType: TimerType
    ) {
        let minutesInSeconds =  minutes * 60
        let totalSeconds = seconds + minutesInSeconds

        if timerType == .roundTimer {
            roundTime = totalSeconds
        } else {
            restTime = totalSeconds
        }
    }
}

#Preview {
    ContentView()
}
