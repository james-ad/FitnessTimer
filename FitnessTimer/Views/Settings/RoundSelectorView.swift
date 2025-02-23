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
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                Text(title)
                    .foregroundStyle(.white)
                    .font(.title)
                    .padding(.bottom, 0)
                
                    Picker(roundPickerLabel, selection: $totalRounds) {
                        ForEach(0...20, id: \.self) { round in
                            Text("\(round)")
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                        }
                    }
                    .pickerStyle(.wheel)
                    .padding(.top, 0)

//                Button(action: {
//                    editModeEnabled.toggle()
//                }) {
//                    Text(saveRoundsLabel)
//                        .font(.callout)
//                        .padding(12)
//                        .foregroundStyle(.black)
//                        .background(.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 8))
//                }
//                .buttonBorderShape(.roundedRectangle)


                Spacer()
            }
            .background(Color.black)
            .frame(maxWidth: .infinity)
        }
        .background(.black)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    @Previewable @State var mockIsEnabled = false
    @Previewable @State var totalRounds = 3
    RoundSelectorView(totalRounds: $totalRounds,
                      editModeEnabled: $mockIsEnabled
    )
}
