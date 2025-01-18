//
//  RoundsSelectorView.swift
//  FitnessTimer
//
//  Created by James Dunn on 1/16/25.
//


import SwiftUI

struct RoundsSelectorView: View {
    @EnvironmentObject var timerStateManager: TimerStateManager
    @State private var editModeEnabled: Bool = false
    private let title = "Rounds"

    // TODO: CLEANUP ROUND PICKER CODE BELOW


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
            .fullScreenCover(isPresented: $editModeEnabled) {

                // TODO: Replace TimerSelectorView with a round picker

                ZStack {
                    VStack(alignment: .center, spacing: 100) {
                        Picker(title, selection: $timerStateManager.totalRounds) {
                            ForEach(1...20, id: \.self) { round in
                                Text("\(round)")
                                    .foregroundStyle(.white)
                            }
                        }
                        .pickerStyle(.wheel)

                        Button(action: {
                            editModeEnabled.toggle()
                        }) {
                            Text("Save")
                                .font(.callout)
                                .padding(12)
                                .foregroundStyle(.black)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .buttonBorderShape(.roundedRectangle)
                    }
                    .background(Color.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .presentationDetents([.large])
                }
                .background(.black)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
