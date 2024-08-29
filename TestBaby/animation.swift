//
//  animation.swift
//  TestBaby
//
//  Created by Daniel Jesus Callisaya Hidalgo on 8/5/24.
//

import SwiftUI
import Combine

struct SymbolAnimation {
    let scale: CGFloat
    let duration: TimeInterval
    let yOffset: CGFloat

    static let smallToLarge = SymbolAnimation(scale: 2, duration: 1.5, yOffset: 0)
    static let steady = SymbolAnimation(scale: 2, duration: 2, yOffset: 0)
    static let largeToSmall = SymbolAnimation(scale: 0.2, duration: 1.5, yOffset: 0)
    static let jump = SymbolAnimation(scale: 2, duration: 1, yOffset: -100)
}

struct AnimatedSymbolView: View {
    let symbolName: String
    let onAnimationComplete: () -> Void
    let animation: SymbolAnimation
    @Binding var remainingTime: Int
    @State private var scale: CGFloat = 0.2
    @State private var yOffset: CGFloat = 0
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var elapsedTime: TimeInterval = 0

    var body: some View {
        VStack {
            Image(systemName: symbolName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .scaleEffect(scale)
                .offset(y: yOffset)
                .animation(.easeInOut(duration: animation.duration), value: scale)
                .animation(.easeInOut(duration: animation.duration), value: yOffset)
                .onAppear {
                    startAnimationCycle()
                }

            Text("Tiempo restante: \(remainingTime)")
                .font(.headline)
                .padding(.top, 10)
        }
        .onReceive(timer) { _ in
            elapsedTime += 0.1
            if elapsedTime >= animation.duration {
                elapsedTime = 0
                advanceState()
            }
        }
    }

    private func startAnimationCycle() {
        advanceState()
    }

    private func advanceState() {
        scale = animation.scale
        yOffset = animation.yOffset
        DispatchQueue.main.asyncAfter(deadline: .now() + animation.duration) {
            onAnimationComplete()
        }
    }
}