//
//  ButtonRow.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/5/24.
//

import Combine
import SwiftUI

struct ButtonRowView: View  {
    @EnvironmentObject private var timerStateManager: TimerStateManager
    private let customGray = Color(red: 0.30, green: 0.30, blue: 0.30)
    private let lineWidth: CGFloat = 2

    var body: some View {
        HStack {
            Button(action: restartTimer) {
                Image(systemName: "arrow.uturn.backward")
                    .font(.title2)
                    .padding(15)
                    .background(Color.black)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(.gray, lineWidth: lineWidth)
                    )
            }
            .foregroundStyle(.white)
            .buttonBorderShape(.circle)
            .buttonStyle(.bordered)

            Spacer()

            Button(action: startOrStopTimer) {
                Text(timerStateManager.buttonTitle)
                    .font(.callout)
                    .foregroundStyle(.white)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 50)
                    .background(customGray)
                    .cornerRadius(50)
            }
            .buttonBorderShape(.capsule)
            .offset(y: -20)

            Spacer()

            Button(action: goToSettings) {
                Image(systemName: "gearshape")
                    .font(.title)
                    .padding(5)
            }
            .buttonBorderShape(.circle)
            .buttonStyle(.bordered)
            .foregroundStyle(.white)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(.gray, lineWidth: lineWidth)
            )
        }
        .padding(.bottom, 20)
        .safeAreaPadding()
    }

    private func restartTimer() {
        timerStateManager.resetTimer()
    }

    private func startOrStopTimer() {
        if timerStateManager.isRunning {
            timerStateManager.stopTimer()
        } else {
            timerStateManager.startTiimer()
        }
    }

    private func goToSettings() {

    }
}

#Preview {
    ContentView()
}
