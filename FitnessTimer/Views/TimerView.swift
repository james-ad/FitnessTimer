//
//  TimeDisplay.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/5/24.
//

import Combine
import SwiftUI

struct TimerView: View, TimeDisplaying {
    @EnvironmentObject var timerStateManager: TimerStateManager
    var timerType: TimerType = .currentTimer

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
