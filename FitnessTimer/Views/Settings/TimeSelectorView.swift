//
//  TimeSelectorView.swift
//  FitnessTimer
//
//  Created by James Dunn on 1/10/25.
//

import SwiftUI

@Observable class TimeSelectorViewModel {
    var minutesSelected: Int = 0
    var secondsSelected: Int = 0
}

struct TimeSelectorView: View {
    @EnvironmentObject private var timerStateManager: TimerStateManager
    @Environment(\.dismiss) var dismiss


    // TODO: Broken currently. Fix so that view model holds state and populates Picker with said state



    @Bindable private var viewModel = TimeSelectorViewModel()
    private let timerType: TimerType
    private let title: String

    init(timerType: TimerType) {
        self.timerType = timerType
        self.title = timerType == .roundTimer ? "Round time" : "Rest time"
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
                        Picker("Minutes", selection: $viewModel.minutesSelected) {
                            ForEach(0..<60, id: \.self) { number in
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
                        Picker("Seconds", selection: $viewModel.secondsSelected) {
                            ForEach(0..<60, id: \.self) { number in
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
                Button(
                    action: {
                        timerStateManager
                            .setTime(
                                minutes: viewModel.minutesSelected,
                                seconds: viewModel.secondsSelected,
                                forTimerType: timerType
                            )
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
