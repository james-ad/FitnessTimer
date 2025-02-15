//
//  ContentView.swift
//  FitnessTimer
//
//  Created by James Dunn on 9/28/24.
//

import SwiftUI

struct ContentView: View {
    @Bindable var timerStateManager = TimerStateManager()

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            TimerView()
                .frame(maxWidth: .infinity)
                .environment(timerStateManager)
            Spacer()
            Spacer()
            ButtonRowView(timerStateManager: _timerStateManager)
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}




#Preview {
    ContentView()
}
