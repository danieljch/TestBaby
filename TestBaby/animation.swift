//
//  animation.swift
//  TestBaby
//
//  Created by Daniel Jesus Callisaya Hidalgo on 8/5/24.
//
import SwiftUI

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
        case .smallToLarge: return 0.2
        case .steady, .largeToSmall, .jump: return 2
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
    private let animationDuration: TimeInterval = 2
    private let steadyDuration: TimeInterval = 2
    private let jumpDuration: TimeInterval = 0.5

    var body: some View {
        VStack {
            Image(systemName: symbolName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .scaleEffect(scale)
                .offset(y: yOffset)
                .animation(.easeInOut(duration: animationDuration), value: scale)
                .animation(.easeInOut(duration: jumpDuration), value: yOffset)
                .onAppear {
                    startAnimationCycle()
                }

            Text("Tiempo restante: \(remainingTime)")
                .font(.headline)
                .padding(.top, 10)
        }
    }

    private func startAnimationCycle() {
        switch state {
        case .smallToLarge:
            scale = state.scale
            state = state.nextState
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                remainingTime = 4
                startAnimationCycle()
            }
        case .steady:
            scale = state.scale
            state = state.nextState
            DispatchQueue.main.asyncAfter(deadline: .now() + steadyDuration) {
                remainingTime = 3
                startAnimationCycle()
            }
        case .jump:
            yOffset = -30
            DispatchQueue.main.asyncAfter(deadline: .now() + jumpDuration / 2) {
                yOffset = 0
            }
            state = state.nextState
            DispatchQueue.main.asyncAfter(deadline: .now() + jumpDuration) {
                remainingTime = 2
                startAnimationCycle()
            }
        case .largeToSmall:
            scale = 0.2
            state = state.nextState
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                remainingTime = 0
                onAnimationComplete()
            }
        }
    }
}
