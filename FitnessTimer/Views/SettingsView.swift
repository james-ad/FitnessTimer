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

private struct SettingsTimerView: View, TimeDisplaying {
    @EnvironmentObject var timerStateManager: TimerStateManager
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

            // timeDisplayed lives in protocol  extension
            Text("\(timeDisplayed)")
                .font(.title)
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)

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

// This struct and the one above are similar, but I'd like to keep the round tracker separate from time trackers
private struct SetNumberOfRoundsView: View {
    @EnvironmentObject var timerStateManager: TimerStateManager
    @State private var editModeEnabled: Bool = false
    private let title = "Rounds"

    var body: some View {
        HStack(alignment: .center) {
            Text("\(title): ")
                .font(.title)
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)

            // timeDisplayed lives in protocol  extension
            Text("\(timerStateManager.totalRounds)")
                .font(.title)
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)

            Spacer()

            Button(action: { editModeEnabled.toggle() }) {
                Image(systemName: "chevron.forward")
                    .imageScale(.large)
            }
            .sheet(isPresented: $editModeEnabled) {

                // TODO: Replace TimerSelectorView with a round picker
                
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
