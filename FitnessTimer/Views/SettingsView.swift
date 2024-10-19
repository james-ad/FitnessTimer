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
                RoundTimeView()
                RestTimeView()
            }
            .safeAreaPadding()
            Spacer()

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaPadding()
        .background(.black)
    }
}


// TODO: SEE ABOUT MAKING THIS A REUSABLE VIEW SINCE THE LAYOUT IS IDENTICAL MINUS THE DATA AND TRACKED TIMER
struct RoundTimeView: View, TimeDisplaying {
    @EnvironmentObject var timerStateManager: TimerStateManager
    var timerType: TimerType = .roundTimer

    var body: some View {
        HStack {
            Spacer()
            Text("Round time: ")
                .font(.title)
                .foregroundStyle(.white)

            Text("\(timeDisplayed)")
                .font(.title)
                .foregroundStyle(.white)

            Spacer()
            Spacer()
            Button(action: { print("Button tapped") }) {
                Image(systemName: "chevron.forward")
                    .imageScale(.large)
            }
        }
    }
}

struct RestTimeView: View, TimeDisplaying {
    @EnvironmentObject var timerStateManager: TimerStateManager
    var timerType: TimerType = .restTimer


    var body: some View {
        HStack {
            Spacer()
            Text("Rest time: ")
                .font(.title)
                .foregroundStyle(.white)

            Text("\(timeDisplayed)")
                .font(.title)
                .foregroundStyle(.white)

            Spacer()
            Spacer()
            Button(action: { print("Button tapped") }) {
                Image(systemName: "chevron.forward")
                    .imageScale(.large)
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(TimerStateManager())
}
