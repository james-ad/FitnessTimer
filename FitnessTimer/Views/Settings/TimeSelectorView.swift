//
//  TimeSelectorView.swift
//  FitnessTimer
//
//  Created by James Dunn on 1/10/25.
//

import SwiftUI

struct TimeSelectorView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var storedTime: (seconds: Int, minutes: Int)
    private let setTime: @Sendable (TimerType) -> Void
    private let timerType: TimerType
    private var title: String {
        timerType == .roundTimer
        ? String(localized: "Round time")
        : String(localized: "Rest time")
    }

    init(timerType: TimerType,
         storedTime: Binding<(seconds: Int, minutes: Int)>,
         setTime: @Sendable @escaping (TimerType) -> Void
    ) {
        self.timerType = timerType
        self._storedTime = storedTime
        self.setTime = setTime
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
                        Picker("Minutes", selection: $storedTime.minutes) {
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
                        Picker("Seconds", selection: $storedTime.seconds) {
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
                        setTime(timerType)
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
    @Previewable @State var timerStateManager = TimerStateManager()
    TimeSelectorView(
        timerType: .roundTimer,
        storedTime: $timerStateManager.roundPickerTime,
        setTime: timerStateManager.setTime(forTimerType:)
    )
    .environment(timerStateManager)
}
