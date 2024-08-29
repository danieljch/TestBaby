//
//  Baby.swift
//  TestBaby
//
//  Created by Daniel Jesus Callisaya Hidalgo on 26/1/24.
//

import SwiftUI
import Combine

struct SymbolsView: View {
    @State private var oo = SymbolsOO()
    @State private var remainingTime = 6
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var currentAnimation: SymbolAnimation = .smallToLarge

    var body: some View {
        VStack {
            if let symbol = oo.currentSymbol {
                AnimatedSymbolView(symbolName: symbol.name, onAnimationComplete: {
                    oo.nextSymbol()
                    remainingTime = 6
                    currentAnimation = nextAnimation()
                }, animation: currentAnimation, remainingTime: $remainingTime)
                .id(symbol.id)
            }
        }
        .font(.largeTitle)
        .onAppear {
            remainingTime = 6
        }
        .onReceive(timer) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                oo.nextSymbol()
                remainingTime = 6
                currentAnimation = nextAnimation()
            }
        }
    }

    private func nextAnimation() -> SymbolAnimation {
        // Define the logic to select the next animation
        // For example, cycle through predefined animations
        let animations: [SymbolAnimation] = [.smallToLarge, .steady, .jump, .largeToSmall]
        if let currentIndex = animations.firstIndex(where: { $0.scale == currentAnimation.scale && $0.yOffset == currentAnimation.yOffset }) {
            let nextIndex = (currentIndex + 1) % animations.count
            return animations[nextIndex]
        }
        return .smallToLarge
    }
}

#Preview {
   SymbolsView()
}