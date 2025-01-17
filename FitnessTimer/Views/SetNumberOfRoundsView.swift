//
//  SetNumberOfRoundsView.swift
//  FitnessTimer
//
//  Created by James Dunn on 1/16/25.
//


import SwiftUI

// This struct and SettingsTimerView are similar, but I'd like to keep the round tracker separate from time trackers
struct SetNumberOfRoundsView: View {
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
