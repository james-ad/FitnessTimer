//
//  TimerSettingsView.swift
//  FitnessTimer
//
//  Created by James Dunn on 2/24/25.
//


import Combine
import SwiftUI

struct TimerSettingsView: View {
    @Bindable private var timerStateManager: TimerStateManager
    private let setTime: @Sendable () -> Void
    @Environment(\.dismiss) private var dismiss
    
    init(timerStateManager: BindableStateManager,
         setTime: @Sendable @escaping () -> Void
    ) {
        self._timerStateManager = timerStateManager
        self.setTime = setTime
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Spacer()

            TimeSelectorView(
                timerType: .roundTimer,
                storedTime: $timerStateManager.roundPickerTime
            )
            .containerRelativeFrame(.vertical, alignment: .center) { height, _ in height / 4 }
            
            TimeSelectorView(
                timerType: .restTimer,
                storedTime: $timerStateManager.restPickerTime
            )
            .containerRelativeFrame(.vertical, alignment: .center) { height, _ in height / 4 }
            
            RoundSelectorView(totalRounds: $timerStateManager.totalRounds)
            .containerRelativeFrame(.vertical, alignment: .center) { height, _ in height / 4 }
            
            Spacer()
            
            Button(
                action: {
                    setTime()
                    dismiss()
                }) {
                    Text("Save")
                        .font(
                            .system(size: 17, weight: .medium)
                        )
                        .kerning(3)
                        .padding(.vertical, 13)
                        .padding(.horizontal, 40)
                        .foregroundStyle(.black)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .buttonBorderShape(.roundedRectangle)
                .padding(.bottom)
            
            Spacer()
            Spacer()
        }
        .padding(5)
        .background(.black)
    }
}

#Preview {
    @Previewable @Bindable var timerStateManager = TimerStateManager()
    TimerSettingsView(timerStateManager: $timerStateManager,
                      setTime: timerStateManager.setTime
    )
}
