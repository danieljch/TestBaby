//
//  ContentView.swift
//  TestBaby
//
//  Created by Daniel Jesus Callisaya Hidalgo on 24/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true

    var body: some View {
        Text("Time Remaining: \(timeRemaining)")
            .padding()
            .onReceive(timer) { _ in
                guard isActive else { return }

                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
            }
            .onChange(of: scenePhase) { oldPhase, newPhase in
                if newPhase == .active {
                    isActive = true
                } else {
                    isActive = false
                }
            }
    }
}


#Preview {
    ContentView()
}
