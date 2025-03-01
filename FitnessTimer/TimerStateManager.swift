//
//  TimerStateManager.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/10/24.
//

import Combine
import SwiftUI

typealias BindableStateManager = Bindable<TimerStateManager>

@Observable class TimerStateManager {

    // MARK: Private properties
    private var restFinished: Bool = false
    private var roundFinished: Bool = false
    var timerType: TimerType = .mainTimer

    var subscription: Cancellable?
    var publisher = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()

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

    // MARK: Time settings
    var timerIsRunning: Bool = false
    var roundNumber: Int = 0
    var restPickerTime = (seconds: 2, minutes: 2)
    var roundPickerTime = (seconds: 2, minutes: 2)
    var currentRound: Int = 2
    var restTime: Int = 0
    var roundTime: Int = 0
    var totalSeconds: Int = 0

    var totalRounds: Int = 2 {
        didSet {
            currentRound = totalRounds
        }
    }

    // MARK: Timer functionality
    // Private
    private func updateRounds() {
        if roundFinished && restFinished {
            currentRound -= 1
            roundFinished.toggle()
            restFinished.toggle()

            if currentRound == 0 {
                stopTimer()
                restartTimer()
                timerType = .mainTimer
                totalSeconds = roundTime
                currentRound = totalRounds
            }
        }
    }

    // Internal
    func resetTimer() {
        totalRounds = 0
        totalSeconds = 0
        roundTime = 0
        restTime = 0
        timerType = .mainTimer
        roundFinished = false
        restFinished = false
        timerIsRunning = false
        buttonTitle = String(localized: "START")
    }
    
    func restartTimer() {
        totalSeconds = roundTime
        currentRound = totalRounds
    }

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

        updateRounds()
    }

    func toggleTimer() {
        if timerIsRunning {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    func startTimer() {

        subscription = publisher.prefix(while: { [weak self] _ in
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
        subscription?.cancel()
        subscription = nil
        timerIsRunning = false
        buttonTitle = String(localized: "START")
    }

    @Sendable
    func setTime() {
        let roundMinutesInSeconds =  roundPickerTime.minutes * 60
        let roundTimeInSeconds = roundPickerTime.seconds + roundMinutesInSeconds
        let restMinutesInSeconds =  restPickerTime.minutes * 60
        let restTimeInSeconds = restPickerTime.seconds + restMinutesInSeconds
        
        // totalSeconds is only set for the .roundTimer block because totalSeconds affects the main screen timer
        // we only want to set the main screen timer to match round time since rest time only displays after the round finishes
        roundTime = roundTimeInSeconds
        totalSeconds = roundTime
        restTime =  restTimeInSeconds
    }
}

#Preview {
        ContentView()
    }
