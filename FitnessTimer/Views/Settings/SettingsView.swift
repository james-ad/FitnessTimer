//
//  SettingsView.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/16/24.
//

import SwiftUI

struct SettingsView: View  {
    @Bindable private var timerStateManager: TimerStateManager
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

            Spacer()
            Spacer()

            // MARK: Timer Settings
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
