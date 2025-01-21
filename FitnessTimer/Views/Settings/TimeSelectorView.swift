//
//  TimeSelectorView.swift
//  FitnessTimer
//
//  Created by James Dunn on 1/10/25.
//

import SwiftUI

struct TimeSelectorView: View {
    @Environment(\.dismiss) var dismiss
    @State var minutesSelected: Int = 0
    @State var secondsSelected: Int = 0
    private var timerType: TimerType
    private var title: String {
        timerType == .roundTimer ? "Round time" : "Rest time"
    }

    init(timerType: TimerType) {
        self.timerType = timerType
    }

    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .center, spacing: 100) {
                Spacer()
                Text(title)
                    .foregroundStyle(.white)
                    .font(.title)

                // MARK: Minutes
                HStack {
                    VStack(alignment: .center, spacing: 30) {
                        Picker("Minutes", selection: $minutesSelected) {
                            ForEach(1..<60, id: \.self) { number in
                                Text("\(number)").tag(number)
                                    .foregroundStyle(.white)
                                    .font(.title)
                            }
                            .background(.black)
                        }
                        .pickerStyle(.wheel)

                        Text("Minutes")
                            .foregroundStyle(.white)
                            .font(.title2)

                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                    // MARK: Seconds
                    VStack(alignment: .center, spacing: 30) {
                        Picker("Seconds", selection: $secondsSelected) {
                            ForEach(1..<60, id: \.self) { number in
                                Text("\(number)").tag(number)
                                    .foregroundStyle(.white)
                                    .font(.title)
                            }
                            .background(.black)
                        }
                        .pickerStyle(.wheel)

                        Text("Seconds")
                            .foregroundStyle(.white)
                            .font(.title2)

                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }

            // MARK: Save button
                Button(action: {
                    dismiss()
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .offset(y: 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .safeAreaPadding()
    }
}

#Preview {
    TimeSelectorView(timerType: .roundTimer)
}
