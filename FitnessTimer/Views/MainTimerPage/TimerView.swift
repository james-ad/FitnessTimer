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
    var timerType: TimerType = .mainTimer

    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray, style: StrokeStyle(lineWidth: 10))
                .zIndex(1)

            VStack(alignment: .center, spacing: 20) {

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
            .offset(y: 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .safeAreaPadding()
    }
}


#Preview {
    ContentView()
}
