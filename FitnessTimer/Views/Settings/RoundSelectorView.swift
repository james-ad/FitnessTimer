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

    public init(totalRounds: Binding<Int>, editModeEnabled: Binding<Bool>) {
        self._totalRounds = totalRounds
        self._editModeEnabled = editModeEnabled
    }

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 100) {
                Spacer()
                Text("Number of Rounds")
                    .foregroundStyle(.white)
                    .font(.title)

                VStack(alignment: .center, spacing: 10) {
                    Picker("Rounds", selection: $totalRounds) {
                        ForEach(1...20, id: \.self) { round in
                            Text("\(round)")
                                .foregroundStyle(.white)
                                .font(.largeTitle)
                        }
                    }
                    .pickerStyle(.wheel)
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
    @Previewable @State var totalRounds = 3
    RoundSelectorView(totalRounds: $totalRounds,
                      editModeEnabled: $mockIsEnabled
    )
}
