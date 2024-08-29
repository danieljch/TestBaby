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

    var body: some View {
        VStack {
            if let symbol = oo.currentSymbol {
                AnimatedSymbolView(symbolName: symbol.name, onAnimationComplete: {
                    oo.nextSymbol()
                    remainingTime = 6
                }, remainingTime: $remainingTime)
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
            }
        }
    }
}

#Preview {
   SymbolsView()
}