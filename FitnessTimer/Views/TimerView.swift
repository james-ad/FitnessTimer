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

    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray, style: StrokeStyle(lineWidth: 10))

            // Update string to use NumberFormatter
            Text(timerStateManager.time.description)
                .font(.largeTitle)
                .foregroundStyle(.white)
        }
        .safeAreaPadding()
    }
}


#Preview {
    ContentView()
}
