//
//  Baby.swift
//  TestBaby
//
//  Created by Daniel Jesus Callisaya Hidalgo on 26/1/24.
//

// View
import SwiftUI

struct SymbolsView: View {
    @State private var oo = SymbolsOO()
    @State private var remainingTime = 0
    @State private var currentIndex = 0
    @State private var duration: Double = 6.0

    var body: some View {
        TabView(selection: $currentIndex) {
            VStack {
                if let symbol = oo.currentSymbol {
                    AnimatedSymbolView(symbolName: symbol.name, color: symbol.color, onAnimationComplete: { oo.nextSymbol(); remainingTime = Int(duration) }, remainingTime: $remainingTime)
                    .id(symbol.id)
                    Slider(value: $duration, in: 3...10, step: 1) { Text("Duration: \(Int(duration)) seconds") } .padding()
                }
            }
            .tag(0)

            Text("View 2")
                .font(.largeTitle)
                .tag(1)

            Text("View 3")
                .font(.largeTitle)
                .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .onAppear {
            remainingTime = Int(duration)
            startCountdown()
        }
    }

    private func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            }
        }
    }
}



#Preview {
   SymbolsView()
}
