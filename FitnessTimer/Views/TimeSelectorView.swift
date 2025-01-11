//
//  TimeSelectorView.swift
//  FitnessTimer
//
//  Created by James Dunn on 1/10/25.
//

import SwiftUI

struct TimeSelectorView: View {
    @State var minutesSelected: Int = 0
    @State var secondsSelected: Int = 0

    var body: some View {
        HStack {
            HStack {
                Text("Minutes: ")
                Picker("Minutes", selection: $minutesSelected) {
                    ForEach(0..<60, id: \.self) { number in
                        Text("\(number)").tag(number)
                            .foregroundStyle(.black)
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                }
            }

            HStack {
                Text("Seconds: ")
                Picker("Seconds", selection: $secondsSelected) {
                    ForEach(0..<60, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                }
            }
        }
        .background(.clear)
    }
}
