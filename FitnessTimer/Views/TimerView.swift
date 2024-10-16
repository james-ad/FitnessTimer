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

            VStack(spacing: 40) {
                Text(timeDisplayed)
                    .kerning(2)
                    .font(.largeTitle)
                    .foregroundStyle(.white)

                Text("Round  \(timerStateManager.roundNumber)")
                    .kerning(7)
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundStyle(.white)
            }
            .offset(y: 25)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .fixedSize(horizontal: false, vertical: false)
        }
        .safeAreaPadding()
    }
}


#Preview {
    ContentView()
}
