//
//  ContentView.swift
//  FitnessTimer
//
//  Created by James Dunn on 9/28/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var timerStateManager = TimerStateManager()

    var body: some View {
        VStack {
            Spacer()
            TimerView()
                .environmentObject(timerStateManager)
            Spacer()
            Spacer()
            ButtonRowView()
                .environmentObject(timerStateManager)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}




#Preview {
    ContentView()
}
