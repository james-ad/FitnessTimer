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
                Spacer()
                Text("Number of Rounds")
                    .foregroundStyle(.white)
                    .font(.title)

                VStack(alignment: .center, spacing: 10) {
                    Picker("Rounds", selection: $timerStateManager.totalRounds) {
                        ForEach(1...20, id: \.self) { round in
                            Text("\(round)")
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                        }
                    }
                    .pickerStyle(.wheel)
//                Text("Rounds")
//                    .foregroundStyle(.white)
//                    .font(.title)
                }

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


                Spacer()
            }
            .background(Color.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    @Previewable @State var mockIsEnabled = false
    RoundSelectorView(timerStateManager: EnvironmentObject<TimerStateManager>(), editModeEnabled: $mockIsEnabled)
        .environmentObject(TimerStateManager())
}
