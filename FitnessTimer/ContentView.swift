//
//  ContentView.swift
//  FitnessTimer
//
//  Created by James Dunn on 9/28/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            TimerView()
            Spacer()
            Spacer()
            ButtonRowView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}




#Preview {
    ContentView()
}
