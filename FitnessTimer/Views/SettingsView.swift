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
            HStack(spacing: 65){
                Text(title)
                    .kerning(3)
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .foregroundStyle(.white)

                Button(action: {
                    print("Button tapped")
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 45, height: 45)
                        .foregroundStyle(.black)
                        .background(.white)
                        .clipShape(.circle)
                        .overlay {
                            Circle()
                                .stroke(Color.gray, lineWidth: 3)
                        }
                }
            }
            .offset(x: 56, y: 20)
            .safeAreaPadding()

            Spacer()
            Spacer()

            // MARK: Timer Settings
            VStack(alignment: .leading, spacing: 20) {
                // TODO: FIX ALIGNMENT SO TIME ROWS ARE LEFT-ALIGNED
                // The negative leading padding is a temporary fix
                SettingsTimerView(timerType: .roundTimer)
                SettingsTimerView(timerType: .restTimer)
                    .padding(.leading, -10)
            }
            .safeAreaPadding()
            Spacer()

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaPadding()
        .background(.black)
    }
}

struct SettingsTimerView: View, TimeDisplaying {
    @EnvironmentObject var timerStateManager: TimerStateManager
    @State private var editModeEnabled: Bool = false
    var timerType: TimerType
    private var title: String {
        timerType == .roundTimer ? "Round time" : "Rest time"
    }

    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .font(.title)
                .foregroundStyle(.white)

            Text("\(timeDisplayed)")
                .font(.title)
                .foregroundStyle(.white)

            Spacer()
            Spacer()
            Button(action: { editModeEnabled.toggle() }) {
                Image(systemName: "chevron.forward")
                    .imageScale(.large)
            }
            .sheet(isPresented: $editModeEnabled) {
                TimeSelector()
            }
        }
    }
}

struct TimeSelector: View {
    @State var minutesSelected: Int = 0
    @State var secondsSelected: Int = 0

    var body: some View {
        HStack {
            HStack {
                Text("Minutes: ")
                Picker("Minutes", selection: $minutesSelected) {
                    ForEach(0..<60, id: \.self) { number in
                        Text("\(number)").tag(number)
                            .foregroundStyle(.black)
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                }
            }

            HStack {
                Text("Seconds: ")
                Picker("Seconds", selection: $secondsSelected) {
                    ForEach(0..<60, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                }
            }
        }
        .background(.clear)
    }
}

#Preview {
    SettingsView()
        .environmentObject(TimerStateManager())
}
