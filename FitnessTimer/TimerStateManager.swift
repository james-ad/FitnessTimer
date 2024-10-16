//
//  TimerStateManager.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/10/24.
//

import Combine
import SwiftUI

class TimerStateManager: ObservableObject {
    @Published var time: Int = 0
    @Published var buttonTitle: String = "START"
    @Published var isRunning: Bool = false
    // Might need pause status later to distinguish between pause and stop
    @Published var isPaused: Bool = false
    @Published var isFinished: Bool = false
    @Published var roundNumber: Int = 0

    private var cancellable: Cancellable?

    func startTimer() {
        cancellable = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.time += 1
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
        time = 0
    }
}

#Preview {
    ContentView()
}
