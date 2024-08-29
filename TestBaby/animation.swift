//
//
//  animation.swift
//  TestBaby
//
//  Created by Daniel Jesus Callisaya Hidalgo on 8/5/24.
//

import SwiftUI
import Combine

enum SymbolAnimationState {
    case smallToLarge
    case steady
    case largeToSmall
    case jump

    var nextState: SymbolAnimationState {
        switch self {
        case .smallToLarge: return .steady
        case .steady: return .jump
        case .jump: return .largeToSmall
        case .largeToSmall: return .smallToLarge
        }
    }

    var scale: CGFloat {
        switch self {
        case .smallToLarge: return 2
        case .steady, .largeToSmall, .jump: return 2
        }
    }

    var duration: TimeInterval {
        switch self {
        case .smallToLarge, .largeToSmall: return 1.5
        case .steady: return 2
        case .jump: return 1
        }
    }
}

struct AnimatedSymbolView: View {
    let symbolName: String
    let onAnimationComplete: () -> Void
    @Binding var remainingTime: Int
    @State private var state: SymbolAnimationState = .smallToLarge
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
                .animation(.easeInOut(duration: state.duration), value: scale)
                .animation(.easeInOut(duration: state.duration), value: yOffset)
                .onAppear {
                    startAnimationCycle()
                }

            Text("Tiempo restante: \(remainingTime)")
                .font(.headline)
                .padding(.top, 10)
        }
        .onReceive(timer) { _ in
            elapsedTime += 0.1
            if elapsedTime >= state.duration {
                elapsedTime = 0
                advanceState()
            }
        }
    }

    private func startAnimationCycle() {
        advanceState()
    }

    private func advanceState() {
        switch state {
        case .smallToLarge:
            scale = state.scale
            state = state.nextState
        case .steady:
            scale = state.scale
            state = state.nextState
        case .jump:
            yOffset = -30
            DispatchQueue.main.asyncAfter(deadline: .now() + state.duration / 2) {
                yOffset = 0
            }
            state = state.nextState
        case .largeToSmall:
            scale = 0.2
            state = state.nextState
            onAnimationComplete()
        }
    }
}