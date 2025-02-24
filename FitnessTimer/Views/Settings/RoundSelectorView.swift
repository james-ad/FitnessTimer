//
//  RoundSelectorView.swift
//  FitnessTimer
//
//  Created by James Dunn on 1/18/25.
//

import SwiftUI

struct RoundSelectorView: View {
    @Binding private var totalRounds: Int
    @Binding private var editModeEnabled: Bool
    private let roundPickerLabel = String(localized: "Rounds")
    private let saveRoundsLabel = String(localized: "Save")
    private let title = String(localized: "Rounds")
    
    public init(totalRounds: Binding<Int>, editModeEnabled: Binding<Bool>) {
        self._totalRounds = totalRounds
        self._editModeEnabled = editModeEnabled
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            
            Text(title)
                .foregroundStyle(.white)
                .font(.title)
                .offset(y: 10)
            
            Picker(roundPickerLabel, selection: $totalRounds) {
                ForEach(0...20, id: \.self) { round in
                    Text("\(round)")
                        .foregroundStyle(.white)
                        .font(.title)
                }
            }
            .pickerStyle(.wheel)
            .padding(.top, 0)
            .offset(y: -20)
            
            Spacer()
            
        }
        .background(Color.black)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    @Previewable @State var mockIsEnabled = false
    @Previewable @State var totalRounds = 3
    RoundSelectorView(totalRounds: $totalRounds,
                      editModeEnabled: $mockIsEnabled
    )
}
