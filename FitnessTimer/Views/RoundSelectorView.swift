//
//  RoundSelectorView.swift
//  FitnessTimer
//
//  Created by James Dunn on 1/18/25.
//

import SwiftUI

struct RoundSelectorView: View {
    @EnvironmentObject var timerStateManager: TimerStateManager
    @Binding private var editModeEnabled: Bool

    public init(timerStateManager: EnvironmentObject<TimerStateManager>, editModeEnabled: Binding<Bool>) {
        self._timerStateManager = timerStateManager
        self._editModeEnabled = editModeEnabled
    }

    // TODO: CLEANUP ROUND PICKER CODE BELOW

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 100) {
                Picker("Rounds", selection: $timerStateManager.totalRounds) {
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
