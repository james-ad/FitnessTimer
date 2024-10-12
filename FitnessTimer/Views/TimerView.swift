//
//  TimeDisplay.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/5/24.
//

import Combine
import SwiftUI

struct TimerView: View {
    @EnvironmentObject private var timerStateManager: TimerStateManager
    private var timeDisplayed: String {
        let hours = timerStateManager.time / 3600
        let minutes = (timerStateManager.time % 3600) / 60
        let seconds = timerStateManager.time % 60
        if hours < 1 {
            return String(format: "%02d:%02d", minutes, seconds)
        } else {
            return String(format: "%i:%02d:%02d", hours, minutes, seconds)
        }
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray, style: StrokeStyle(lineWidth: 10))

            Text(timeDisplayed)
                .font(.largeTitle)
                .foregroundStyle(.white)
        }
        .safeAreaPadding()
    }
}


#Preview {
    ContentView()
}
