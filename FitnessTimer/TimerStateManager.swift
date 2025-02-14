//
//  TimerStateManager.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/10/24.
//

import Combine
import SwiftUI

@Observable class TimerStateManager {
    // MARK: Private properties
    @ObservationIgnored private var cancellable: Cancellable?
    private var timerType: TimerType = .mainTimer
    private var roundFinished: Bool = false
    private var restFinished: Bool = false

    // MARK: Timer labels
    var buttonTitle = String(localized: "START")
    var roundTitle: String {
        switch self.timerType {
            case .mainTimer:
                String(localized: "ROUNDS")
            case .roundTimer:
                String(localized: "ROUND")
            case .restTimer:
                String(localized: "REST")
        }
    }

    // MARK: Timer statuses
    var isFinished: Bool = false
    
    // Might need pause status later to distinguish between pause and stop
    var isPaused: Bool = false
    var isRunning: Bool = false
    var roundIsOver: Bool = true

    // MARK: Time settings
    var timerIsRunning: Bool = false
    var roundNumber: Int = 0
    var restPickerTime = (seconds: 0, minutes: 0)
    var roundPickerTime = (seconds: 0, minutes: 0)
    var currentRound: Int = 0
    var restTime: Int = 0
    var roundTime: Int = 0
    var totalSeconds: Int = 0
    var totalRounds: Int = 0 {
        didSet(newValue) {
            currentRound = totalRounds
        }
    }

    // MARK: Timer functionality
    func switchTimer() {
        if [.mainTimer, .roundTimer].contains(self.timerType) {
            totalSeconds = restTime
            self.timerType = .restTimer
            roundFinished = true
        } else {
            totalSeconds = roundTime
            self.timerType = .roundTimer
            restFinished = true
        }

        if roundFinished && restFinished {
            currentRound -= 1
            roundFinished.toggle()
            restFinished.toggle()

            if currentRound == 0 {
                stopTimer()
                resetTimer()
                timerType = .mainTimer
                totalSeconds = roundTime
                currentRound = totalRounds
            }
        }
    }

    func toggleTimer() {
        if timerIsRunning {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    func startTimer() {
        cancellable = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .prefix(while: { [weak self] _ in
                guard let self else { return false }
                return currentRound > 0
            })
            .sink { [weak self] _ in
                guard let self else { return }
                self.totalSeconds -= 1

                if self.totalSeconds < 0 {
                    switchTimer()
                }
            }

        timerIsRunning = true
        buttonTitle = String(localized: "PAUSE")
    }

    func stopTimer() {
        cancellable?.cancel()
        cancellable = nil
        timerIsRunning = false
        buttonTitle = String(localized: "START")
    }

    func resetTimer() {
        totalSeconds = roundTime
        currentRound = totalRounds
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
