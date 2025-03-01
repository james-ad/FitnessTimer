//
//  TimeDisplay.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/5/24.
//

import Combine
import SwiftUI

struct TimerView: View, TimeDisplaying {
    @Environment(TimerStateManager.self) var timerStateManager
    @Binding var remainingTimeInSeconds: Int
    var timerType: TimerType = .mainTimer
    private var timerGauge: Int {
        if [.mainTimer, .roundTimer].contains(timerStateManager.timerType) {
            return max(1, timerStateManager.roundTime)
        } else {
            return max(1, timerStateManager.restTime)
        }
    }


    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray, style: StrokeStyle(lineWidth: 10))
//                .zIndex(1)
            /*
             Task:
                - To draw a circle around the timer view and use the .trim() view modifier
             to trim the new green circle.

                - Each iteration will use the following formula:
                    - trim(from: 0, to: (totalCurrentTimeInSeconds * 100))

             200 seconds
                100 * 200 = 20000
                199 seconds
                100 * 199 = 19900
                0 -> 20000
                0 -> 19900



             120 seconds
                100 * 120 = 12000
                100 * 119 = 11900


             */

            // TODO: FIGURE OUT HOW TO RERENDER THE CIRCLE EACH TIME THE VALUE IS UPDATED
            // TODO: ALSO SUBSCRIBE TO THE STATE MANAGER'S PUBLISHER

            Circle()
                .trim(from: 0, to: CGFloat(remainingTimeInSeconds) / CGFloat(timerGauge))
                .stroke(.green,
                        style: StrokeStyle(
                            lineWidth: 10,
                            lineCap: .round,
                            lineJoin: .round)
                )
                .rotationEffect(.degrees(360))
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: remainingTimeInSeconds)
//                .zIndex(1)

            VStack(alignment: .center, spacing: 10) {

                Text(timeDisplayed)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 60))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .tracking(5)

                VStack(alignment: .center, spacing: 20) {
                    Text(timerStateManager.roundTitle)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .tracking(12)


                    Text("\(timerStateManager.currentRound)")
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
                .font(.title)
                .fontWeight(.light)
                .foregroundStyle(.white)
                .offset(y: 30)
            }
            .aspectRatio(contentMode: .fit)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .safeAreaPadding()
    }
}


#Preview {
    ContentView()
}
