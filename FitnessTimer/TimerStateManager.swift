//
//  TimerStateManager.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/10/24.
//

import Combine
import SwiftUI

class TimerStateManager: ObservableObject {
    @Published var time: Float = 0
    private var cancellable: Cancellable?
    @Published var buttonTitle: String = "Start"
    @Published var isRunning: Bool = false
    // Might need pause status later to distinguish between pause and stop
    @Published var isPaused: Bool = false
    @Published var isFinished: Bool = false
    // 1. Tap button, start timer if not running
        // 1a. If timer is running, stop timer
    // 2. The timer should only be running if isRunning is true
        // 2a. isRunning -> Timer.update()
        // 2b. !isRunning -> Timer.cancel()
        // 2c. Actual value displayed on screen is separate from the resetting and incrementing of the timer

    func startTiimer() {
        cancellable = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.time += 1
            }

        isRunning = true
        buttonTitle = "PAUSE"
    }

    func stopTimer() {
        cancellable?.cancel()
        cancellable = nil
        isRunning = false
        buttonTitle = "START"
    }

    func resetTimer() {
        time = 0
    }
}
