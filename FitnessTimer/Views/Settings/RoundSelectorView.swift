//
//  RoundSelectorView.swift
//  FitnessTimer
//
//  Created by James Dunn on 1/18/25.
//

import SwiftUI

struct RoundSelectorView: View {
    @Binding private var totalRounds: Int
    private let saveRoundsLabel = String(localized: "Save")
    private let title = String(localized: "Rounds")
    
    public init(totalRounds: Binding<Int>) {
        self._totalRounds = totalRounds
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(title)
                .foregroundStyle(.white)
                .font(.largeTitle)
                .kerning(6)
                .background(.black)
                .offset(y: 10)

            Picker(title, selection: $totalRounds) {
                ForEach(0...20, id: \.self) { round in
                    Text("\(round)")
                        .foregroundStyle(.white)
                        .font(.title)
                }
            }
            .pickerStyle(.wheel)
            .scaledToFit()

            Spacer()
        }
        .safeAreaPadding()
        .background(Color.black)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

//#Preview {
//    @Previewable @State var mockIsEnabled = false
//    @Previewable @State var totalRounds = 3
//    RoundSelectorView(totalRounds: $totalRounds)
//}

#Preview {
    @Previewable @Bindable var timerStateManager = TimerStateManager()
    TimerSettingsView(timerStateManager: $timerStateManager,
                      setTime: timerStateManager.setTime
    )
}
