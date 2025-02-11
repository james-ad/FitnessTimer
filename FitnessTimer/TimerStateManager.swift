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
    var roundIsOver: Bool = true

    var roundNumber: Int = 0
    var roundTime: Int = 0
    var restTime: Int = 0
    var totalRounds: Int = 0
    var totalSeconds: Int = 0

    var roundPickerTime = (seconds: 0, minutes: 0)
    var restPickerTime = (seconds: 0, minutes: 0)

    @ObservationIgnored private var cancellable: Cancellable?

    private func switchTimer(to timerType: TimerType) {
        totalSeconds = timerType == .roundTimer ? roundTime : restTime
        if timerType == .restTimer {
            roundTime = roundPickerTime.seconds + (roundPickerTime.minutes * 60)
        } else if timerType == .roundTimer {
            restTime = restPickerTime.seconds + (restPickerTime.minutes * 60)
        }
    }

    func startTimer() {
        cancellable = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .prefix(while: { [weak self] _ in
                guard let self else { return false }
                return totalRounds > 0
            })
            .sink { [weak self] _ in
                guard let self else { return }

                guard self.totalSeconds > 0 else {
                    self.stopTimer()
                    return
                }

                self.totalSeconds -= 1

                if roundTime == 0 {
                    switchTimer(to: .restTimer)
                }

                if restTime == 0 {
                    switchTimer(to: .roundTimer)
                    totalRounds -= 1
                }
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
        let timeInSeconds = seconds + minutesInSeconds

        if timerType == .roundTimer {
            roundTime = timeInSeconds
            totalSeconds = roundTime

        } else {
            restTime = timeInSeconds
        }
    }
}

#Preview {
    ContentView()
}
