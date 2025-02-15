//
//  ButtonRow.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/5/24.
//

import Combine
import SwiftUI

// MARK: Main page button-group view
struct ButtonRowView: View  {
    @Bindable private var timerStateManager: TimerStateManager

    init(timerStateManager: BindableStateManager) {
        self._timerStateManager = timerStateManager
    }

    var body: some View {
        HStack {
            RestartButon(restartTimer: timerStateManager.resetTimer)
            Spacer()

            PlayPauseButton(buttonTitle: timerStateManager.buttonTitle,
                            toggleTimer: timerStateManager.toggleTimer)
            Spacer()

            SettingsButton(timerStateManager: _timerStateManager)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 50)
        .safeAreaPadding()
    }

    // MARK: BUTTON VIEWS

    // MARK: Restart Button
    struct RestartButon: View {
        private let restartTimer: () -> Void
        
        init(restartTimer: @escaping () -> Void) {
            self.restartTimer = restartTimer
        }
        
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

    }

    // MARK: Play/Pause button
    struct PlayPauseButton: View {
        private let buttonTitle: String
        private let toggleTimer: () -> Void
        
        init(buttonTitle: String, toggleTimer: @escaping () -> Void) {
            self.buttonTitle = buttonTitle
            self.toggleTimer = toggleTimer
        }
        
        var body: some View {
            Button(action: toggleTimer) {
                Text(buttonTitle)
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
    }

    // MARK: Settings button
    struct SettingsButton: View {
        @Bindable private var timerStateManager: TimerStateManager
        @State var settingsMenuIsOpen: Bool = false

        init(timerStateManager: BindableStateManager) {
            self._timerStateManager = timerStateManager
        }

        var body: some View {
            Button(action: goToSettings) {
                Image(systemName: "gearshape")
                    .font(.system(size: 24))
                    .padding(12)
                    .background(Color.black)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(.gray, lineWidth: Constants.lineWidth)
                    )
            }
            .foregroundStyle(.white)
            .buttonBorderShape(.circle)
            .buttonStyle(.bordered)
            .fullScreenCover(isPresented: $settingsMenuIsOpen) {
                SettingsView(timerStateManager: timerStateManager)
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

