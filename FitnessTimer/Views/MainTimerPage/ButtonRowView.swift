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
        
        // TODO: CHANGE THIS TO AN HGrid or LazyHGrid
        
        HStack {
            VStack(alignment: .center, spacing: 10) {
                RestartButon(restartTimer: timerStateManager.restartTimer)
                
                // Button to reset all timer settings back to 0
                ResetButon(resetTimer: timerStateManager.resetTimer)
            }
            Spacer()

            PlayPauseButton(buttonTitle: timerStateManager.buttonTitle,
                            toggleTimer: timerStateManager.toggleTimer)
            Spacer()

            VStack(alignment: .center, spacing: 10) {
                TimerSettingsButton(timerStateManager: _timerStateManager)
                AppSettingsButton(timerStateManager: _timerStateManager)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 40)
        .safeAreaPadding()
    }

    // MARK: BUTTON VIEWS

    // MARK: Reset Button
    struct ResetButon: View {
        private let resetTimer: () -> Void
        
        init(resetTimer: @escaping () -> Void) {
            self.resetTimer = resetTimer
        }
        
        var body: some View {
            Button(action: resetTimer) {
                Image(systemName: "arrow.trianglehead.counterclockwise")
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
        }
    }

    // MARK: Settings button
    struct AppSettingsButton: View {
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
    
    
    
    // TODO: ADD ABILITY TO EDIT TIMER SETTINGS FROM THIS BUTTON
    
    
    // MARK: Timer Settings button
    struct TimerSettingsButton: View {
        @State var editModeEnabled: Bool = false
        @Bindable private var timerStateManager: TimerStateManager
        
        init(timerStateManager: BindableStateManager) {
            self._timerStateManager = timerStateManager
        }

        var body: some View {
            Button(action: goToSettings) {
                Image(systemName: "timer")
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
            .fullScreenCover(isPresented: $editModeEnabled) {
                ExtractedView(timerStateManager: $timerStateManager, setTime: timerStateManager.setTime)
                
            }

        }

        private func goToSettings() {
            editModeEnabled.toggle()
        }
    }

}

fileprivate enum Constants {
    static let customGray = Color(red: 0.30, green: 0.30, blue: 0.30)
    static let lineWidth: CGFloat = 2
}


#Preview {
    @Previewable @Bindable var timerStateManager = TimerStateManager()
    ExtractedView(timerStateManager: $timerStateManager,
                  setTime: timerStateManager.setTime
    )
}



// TODO: RENAME VIEW AND FIX SPACING AND SIZING OF SUBVIEWS


struct ExtractedView: View {
    @State var editModeEnabled: Bool = false
    @Bindable private var timerStateManager: TimerStateManager
    private let setTime: @Sendable () -> Void
    @Environment(\.dismiss) private var dismiss
    
    init(timerStateManager: BindableStateManager,
         setTime: @Sendable @escaping () -> Void
    ) {
        self._timerStateManager = timerStateManager
        self.setTime = setTime
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            TimeSelectorView(
                timerType: .roundTimer,
                storedTime: $timerStateManager.roundPickerTime
            )
            
            TimeSelectorView(
                timerType: .restTimer,
                storedTime: $timerStateManager.restPickerTime
            )
            
            RoundSelectorView(
                totalRounds: $timerStateManager.totalRounds,
                editModeEnabled: $editModeEnabled
            )
            
            Spacer()
            
            Button(
                               action: {
                                   setTime()
                                   dismiss()
                               }) {
                                   Text("Save")
                                       .font(.callout)
                                       .padding(12)
                                       .foregroundStyle(.black)
                                       .background(.white)
                                       .clipShape(RoundedRectangle(cornerRadius: 8))
                               }
                               .buttonBorderShape(.roundedRectangle)
        }
        .background(.black)
        .safeAreaPadding(.bottom)
    }
}
