//
//  ContentView.swift
//  FitnessTimer
//
//  Created by James Dunn on 9/28/24.
//

import SwiftUI

struct ContentView: View {
    @State var timerStateManager = TimerStateManager()

    var body: some View {
        VStack {
            Spacer()
            TimerView()
                .environment(timerStateManager)
            Spacer()
            Spacer()
            ButtonRowView()
                .environment(timerStateManager)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}




#Preview {
    ContentView()
}
