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
    private let timerType: TimerType
    private var title: String {
        timerType == .roundTimer
        ? String(localized: "Round time")
        : String(localized: "Rest time")
    }

    init(timerType: TimerType,
         storedTime: Binding<(seconds: Int, minutes: Int)>
    ) {
        self.timerType = timerType
        self._storedTime = storedTime
    }

    
    // TODO: Temp constants until I can organize them better
    private let pickerHorizontalPadding: CGFloat = 100
    private let pickerHorizontalOffset: CGFloat = 10
    private var kerning: CGFloat {
        UIScreen.main.bounds.width <= 375 ? 1.5 : 3
    }
    private var vStackSpacing: CGFloat {
        UIScreen.main.bounds.width <= 375 ? -4 : 1
    }

    var body: some View {
            VStack(alignment: .center, spacing: vStackSpacing) {
                Spacer()
                Text(title)
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .kerning(5)

                // MARK: Minutes
                HStack(alignment: .center) {
                    Picker("Minutes", selection: $storedTime.minutes) {
                        ForEach(0..<60, id: \.self) { number in
                            Text(String(format: "%02d", number)).tag(number)
                                .kerning(kerning)
                                .foregroundStyle(.white)
                                .font(.title)
                                .fixedSize()
                                .offset(x: pickerHorizontalOffset)
                        }
                        .background(.black)
                    }
                    .pickerStyle(.wheel)
                    .padding(.leading, pickerHorizontalPadding)

                    Text(":")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .offset(y: -3.175)
                        .background(.clear)

                    // MARK: Seconds
                    Picker("Seconds", selection: $storedTime.seconds) {
                        ForEach(0..<60, id: \.self) { number in
                            Text(String(format: "%02d", number)).tag(number)
                                .kerning(kerning)
                                .foregroundStyle(.white)
                                .font(.title)
                                .fixedSize()
                                .offset(x: -pickerHorizontalOffset)
                        }
                        .background(.black)
                    }
                    .pickerStyle(.wheel)
                    .padding(.trailing, pickerHorizontalPadding)
                }

                HStack(alignment: .center) {
                    Text("Minutes")
                        .foregroundStyle(.white)
                        .font(.caption)
                        .padding(.trailing, 3)

                    Text("Seconds")
                        .foregroundStyle(.white)
                        .font(.caption)
                        .padding(.leading, 3)
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .safeAreaPadding()
    }
}

#Preview {
    @Previewable @Bindable var timerStateManager = TimerStateManager()
    TimerSettingsView(timerStateManager: $timerStateManager,
                      setTime: timerStateManager.setTime
    )
}

//#Preview {
//    @Previewable @State var timerStateManager = TimerStateManager()
//    TimeSelectorView(
//        timerType: .roundTimer,
//        storedTime: $timerStateManager.roundPickerTime
//    )
//    .environment(timerStateManager)
//}
