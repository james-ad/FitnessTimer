//
//  TimeDisplay.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/5/24.
//


import SwiftUI

struct TimerView: View {
    @State private var timer: Double = 0.0

    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray, style: StrokeStyle(lineWidth: 10))

            // Update string to use NumberFormatter
            Text(String(format: "%2f", timer))
                .font(.largeTitle)
                .foregroundStyle(.white)
        }
        .safeAreaPadding()
    }
}


#Preview {
    ContentView()
}
