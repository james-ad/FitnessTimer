//
//  SettingsView.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/16/24.
//

import SwiftUI

enum SettingsOption: String, CaseIterable, Identifiable {
    case timerSettings, appSettings

    var id: Self { self }
}

struct SettingsView: View  {
    @Bindable private var timerStateManager: TimerStateManager
    @State private var settingsOption: SettingsOption = .timerSettings
    @Environment(\.dismiss) var dismiss
    private let settingsTitle = String(localized: "Settings")

    init(timerStateManager: TimerStateManager) {
        self.timerStateManager = timerStateManager
    }

    var body: some View {
        VStack {
            Spacer()

            Text(settingsTitle)
                .tracking(3)
                .font(.largeTitle)
                .fontWeight(.light)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .safeAreaPadding()

            // TODO: Fix UI for settings option picker (especially edges)

//            Picker("Settings Option", selection: $settingsOption) {
//                Text("Timer Settings").tag(SettingsOptions.timerSettings)
//                Text("App Settings").tag(SettingsOptions.appSettings)
//            }
//            .luminanceToAlpha()
//            .background(.gray)
//            .pickerStyle(.segmented)

            Spacer()
            Spacer()

            // MARK: Timer Settings
            if settingsOption == .timerSettings {
            VStack(alignment: .leading, spacing: 20) {
                SettingsTimerView(timerStateManager: timerStateManager,
                                  timerType: .roundTimer)

                SettingsTimerView(timerStateManager: timerStateManager,
                                  timerType: .restTimer)

                RoundsSelectorButtonView(totalRounds: $timerStateManager.totalRounds)
            }
            .safeAreaPadding()
            .padding(.vertical, 50)
            .offset(y: 10)
            } else {
                // TODO: App Settings can go here

                Text("App Settings")
            }


            Button(action: { dismiss() }) {
                Text("Exit Settings")
                    .font(.callout)
                    .padding(12)
                    .foregroundStyle(.black)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .buttonBorderShape(.roundedRectangle)

            Spacer()
        }
        .safeAreaPadding()
        .background(.black)
    }
}


#Preview {
    @Previewable @State var timerStateManager = TimerStateManager()
    SettingsView(timerStateManager: timerStateManager)
}
