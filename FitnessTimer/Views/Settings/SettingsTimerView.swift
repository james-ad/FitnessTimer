//
//  SettingsTimerView.swift
//  FitnessTimer
//
//  Created by James Dunn on 1/16/25.
//


import SwiftUI

struct SettingsTimerView: View, TimeDisplaying {
    @Bindable var timerStateManager: TimerStateManager
    @State private var editModeEnabled: Bool = false
    var timerType: TimerType
    private var title: String {
        timerType == .roundTimer ? "Round time" : "Rest time"
    }

    var body: some View {
        HStack(alignment: .center) {
            Text("\(title): ")
                .font(.title)
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)

            // timeDisplayed lives in TimeDisplaying protocol extension
            Text("\(timeDisplayed)")
                .font(.title)
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)

            Spacer()

            Button(action: { editModeEnabled.toggle() }) {
                Image(systemName: "chevron.forward")
                    .imageScale(.large)
            }
            .fullScreenCover(isPresented: $editModeEnabled) {
                TimeSelectorView(
                    timerType: timerType,
                    storedTime: timerType == .roundTimer ? $timerStateManager.roundPickerTime : $timerStateManager.restPickerTime,
                    setTime: timerStateManager.setTime(forTimerType:)
                )
            }
        }
        .background(.black)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SettingsTimerView(
        timerStateManager: TimerStateManager(),
        timerType: .roundTimer
    )
    .environment(TimerStateManager())
}
