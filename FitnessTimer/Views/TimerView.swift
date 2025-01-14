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
                .zIndex(1)

            VStack(alignment: .center, spacing: 20) {

                Text(timeDisplayed)
                    .font(.system(size: 60))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .tracking(5)


                VStack(alignment: .center, spacing: 20) {
                    Text("ROUND")
                        .multilineTextAlignment(.center)
                        .tracking(10)


                    Text("\(timerStateManager.roundNumber)")
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
    TimerView()
        .environmentObject(TimerStateManager())
}
