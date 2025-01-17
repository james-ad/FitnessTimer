//
//  SettingsView.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/16/24.
//

import SwiftUI

struct SettingsView: View  {
    @Environment(\.dismiss) var dismiss
    private let settingsTitle = String(localized: "Settings")

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
                SettingsTimerView(timerType: .roundTimer)
                SettingsTimerView(timerType: .restTimer)
                SetNumberOfRoundsView()
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
    SettingsView()
        .environmentObject(TimerStateManager())
}
