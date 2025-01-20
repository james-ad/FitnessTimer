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

    var body: some View {
        VStack {
            Spacer()

            HStack {
                HStack {
                    Text("Minutes: ")
                        .foregroundStyle(.white)
                    Picker("Minutes", selection: $minutesSelected) {
                        ForEach(0..<60, id: \.self) { number in
                            Text("\(number)").tag(number)
                                .foregroundStyle(.white)
                        }
                        .pickerStyle(.wheel)
                        .background(.black)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                    }
                }
                
                HStack {
                    Text("Seconds: ")
                        .foregroundStyle(.white)
                    Picker("Seconds", selection: $secondsSelected) {
                        ForEach(0..<60, id: \.self) { number in
                            Text("\(number)").tag(number)
                        }
                        .pickerStyle(.wheel)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                    }
                }
            }

            Spacer()

            Button(action: {
                print("Button tapped")
                dismiss()
            }) {
                Text("Exit Settings")
                    .font(.callout)
                    .padding(12)
                    .foregroundStyle(.black)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .buttonBorderShape(.roundedRectangle)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .safeAreaPadding()
    }
}

#Preview {
    TimeSelectorView()
}
