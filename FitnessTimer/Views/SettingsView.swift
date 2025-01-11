//
//  SettingsView.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/16/24.
//

import SwiftUI

struct SettingsView: View  {
    @Environment(\.dismiss) var dismiss
    private let title = String(localized: "Settings")

    var body: some View {
        VStack {
            Spacer()

            Text(title)
                .kerning(3)
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
                    .padding(-1)
            }
            .safeAreaPadding()

            Spacer()

            Button(action: {
                print("Button tapped")
                dismiss()
            }) {
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

private struct SettingsTimerView: View, TimeDisplaying {
    @EnvironmentObject var timerStateManager: TimerStateManager
    @State private var editModeEnabled: Bool = false
    var timerType: TimerType
    private var title: String {
        timerType == .roundTimer ? "Round time" : "Rest time"
    }

    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Text("\(title): ")
                .font(.title)
                .foregroundStyle(.white)

            Text("\(timeDisplayed)")
                .font(.title)
                .foregroundStyle(.white)

            // TODO: See if there is a better way to handle this spacing
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()

            Button(action: { editModeEnabled.toggle() }) {
                Image(systemName: "chevron.forward")
                    .imageScale(.large)
            }
            .sheet(isPresented: $editModeEnabled) {
                TimeSelectorView()
            }
        }
        .background(.black)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


#Preview {
    SettingsView()
        .environmentObject(TimerStateManager())
}
