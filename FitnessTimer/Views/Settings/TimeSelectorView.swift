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
    
    
    // MARK: Temp constants until I can organize them better
    private let pickerHorizontalPadding: CGFloat = 100
    private let kerning: CGFloat = 3
    private let pickerHorizontalOffset: CGFloat = 10
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .center, spacing: 1) {
                Spacer()
                Text(title)
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .kerning(5)

                // MARK: Minutes
                HStack {
                        Picker("Minutes", selection: $storedTime.minutes) {
                            ForEach(0..<60, id: \.self) { number in
                                Text(String(format: "%02d", number)).tag(number)
                                    .kerning(kerning)
                                    .foregroundStyle(.white)
                                    .font(.title)
                                    .offset(x: pickerHorizontalOffset)
                            }
                            .background(.black)
                        }
                        .pickerStyle(.wheel)
                        .padding(.leading, pickerHorizontalPadding)
                        
                        Text(":")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .background(.clear)

                    // MARK: Seconds
                        Picker("Seconds", selection: $storedTime.seconds) {
                            ForEach(0..<60, id: \.self) { number in
                                Text(String(format: "%02d", number)).tag(number)
                                    .kerning(kerning)
                                    .foregroundStyle(.white)
                                    .font(.title)
                                    .offset(x: -pickerHorizontalOffset)
                            }
                            .background(.black)
                        }
                        .pickerStyle(.wheel)
                        .padding(.trailing, pickerHorizontalPadding)
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        storedTime: $timerStateManager.roundPickerTime
    )
    .environment(timerStateManager)
}
