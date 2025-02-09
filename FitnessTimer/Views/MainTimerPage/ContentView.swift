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
        VStack(alignment: .center) {
            Spacer()
            TimerView()
                .frame(maxWidth: .infinity)
                .environment(timerStateManager)
            Spacer()
            Spacer()
            ButtonRowView()
                .frame(maxWidth: .infinity)
                .environment(timerStateManager)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}




#Preview {
    ContentView()
}
