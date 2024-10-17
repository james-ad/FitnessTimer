//
//  SettingsView.swift
//  FitnessTimer
//
//  Created by James Dunn on 10/16/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var timerStateManager: TimerStateManager
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

            VStack(spacing: 20) {
                Button(action: { print("Button tapped") }) {
                    Text("Round time")
                        .font(.title)
                        .foregroundStyle(.white)
                }

                // TODO: CHANGE BUTTON STYLING FOR BOTH BUTTONS

                Button(action: { print("Button tapped") }) {
                    Text("Rest time")
                        .font(.title)
                }
            }
            Spacer()

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaPadding()
        .background(.black)
    }
}

#Preview {
    SettingsView()
}
