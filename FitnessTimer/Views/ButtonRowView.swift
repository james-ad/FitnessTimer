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

    var body: some View {
        HStack {
            RestartButon()
            Spacer()

            StartStopButton()
            Spacer()

            SettingsButton()
        }
        .padding(.bottom, 20)
        .safeAreaPadding()
    }


    // MARK: Button Views
    struct RestartButon: View {
        @EnvironmentObject private var timerStateManager: TimerStateManager

        var body: some View {
            Button(action: restartTimer) {
                Image(systemName: "arrow.uturn.backward")
                    .font(.title2)
                    .padding(15)
                    .background(Color.black)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(.gray, lineWidth: Constants.lineWidth)
                    )
            }
            .foregroundStyle(.white)
            .buttonBorderShape(.circle)
            .buttonStyle(.bordered)
        }

        private func restartTimer() {
            timerStateManager.resetTimer()
        }
    }

    struct StartStopButton: View {
        @EnvironmentObject private var timerStateManager: TimerStateManager

        var body: some View {
            Button(action: startOrStopTimer) {
                Text(timerStateManager.buttonTitle)
                    .font(.callout)
                    .foregroundStyle(.white)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 50)
                    .background(Constants.customGray)
                    .cornerRadius(50)
            }
            .buttonBorderShape(.capsule)
            .offset(y: -20)
        }

        private func startOrStopTimer() {
            if timerStateManager.isRunning {
                timerStateManager.stopTimer()
            } else {
                timerStateManager.startTimer()
            }
        }
    }

    struct SettingsButton: View {
        @State var settingsMenuIsOpen: Bool = false

        var body: some View {
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
                Circle().stroke(.gray, lineWidth: Constants.lineWidth)
            )
            .sheet(isPresented: $settingsMenuIsOpen) {
                SettingsView()
            }

        }

        private func goToSettings() {
            settingsMenuIsOpen.toggle()
        }
    }

}

fileprivate enum Constants {
    static let customGray = Color(red: 0.30, green: 0.30, blue: 0.30)
    static let lineWidth: CGFloat = 2
}


#Preview {
    ContentView()
}

