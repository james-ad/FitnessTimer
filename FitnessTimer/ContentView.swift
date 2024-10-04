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
            TimeDisplay()
            Spacer()
            Spacer()
            ButtonRow()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

struct TimeDisplay: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray, style: StrokeStyle(lineWidth: 10))

            Text("Hello, World!")
                .font(.largeTitle)
                .foregroundStyle(.white)
        }
        .safeAreaPadding()
    }
}

struct ButtonRow: View  {
    let customGray = Color(red: 0.30, green: 0.30, blue: 0.30)
    let lineWidth: CGFloat = 2
    var body: some View {
        HStack {
            Button(action: restartTimer) {
                Image(systemName: "arrow.uturn.backward")
                    .font(.title2)
                    .padding(15)
                    .background(Color.black)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(.gray, lineWidth: lineWidth)
                    )
            }
            .foregroundStyle(.white)
            .buttonBorderShape(.circle)
            .buttonStyle(.bordered)

            Spacer()

            Button(action: startOrStopTimer) {
                // TODO: Make the title of this button dynamic based upon the status of the timer
                Text(String(localized: "START"))
                    .font(.callout)
                    .foregroundStyle(.white)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 50)
                    .background(customGray)
                    .cornerRadius(50)
            }
            .buttonBorderShape(.capsule)
            .offset(y: -20)

            Spacer()

            Button(action: goToSettings) {
                Image(systemName: "gearshape")
                    .font(.title)
                    .padding(5)
            }
            .buttonBorderShape(.circle)
            .buttonStyle(.bordered)
            .foregroundStyle(.white)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(.gray, lineWidth: lineWidth)
            )
        }
        .padding(.bottom, 20)
        .safeAreaPadding()
    }

    private func restartTimer() {

    }

    private func startOrStopTimer() {

    }

    private func goToSettings() {

    }
}


#Preview {
    ContentView()
}
