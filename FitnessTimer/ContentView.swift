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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .frame(maxHeight: .infinity)
        .padding()
        
        ButtonRow()
    }
}

struct ButtonRow: View  {
    var body: some View {
        HStack {
            Button(action: restartTimer) {
                Text("Restart")
            }
            .buttonStyle(.bordered)
            .padding()
            
            Button(action: startOrStopTimer) {
                Text("Play/Pause")
            }
            .buttonStyle(.bordered)
            .padding()
            
            Button(action: goToSettings) {
                Text("Settings")
            }
            .buttonStyle(.bordered)
        }
    }
    
    private func restartTimer() {
        
    }
    
    private func startOrStopTimer() {
        
    }
    
    private func goToSettings() {
        
    }
}


//#Preview {
//    ContentView()
//}
