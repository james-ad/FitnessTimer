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

            VStack(alignment: .center) {

                Text(timeDisplayed)
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .kerning(5)
                    .offset(y: 30)

                Spacer(minLength: 50)

                VStack(alignment: .center) {
                    Text("ROUND")

                    Spacer(minLength: -22)

                    Text("\(timerStateManager.roundNumber)")
                }
                .font(.title)
                .fontWeight(.light)
                .foregroundStyle(.white)
                .kerning(16)
                .frame(maxWidth: .infinity, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .padding(.vertical, -30)
            }
            .aspectRatio(contentMode: .fit)
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
