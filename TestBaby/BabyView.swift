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
    @State private var currentSymbolIndex = 0

    let animationDuration: TimeInterval = 3.0

    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            if let symbol = oo.data[safe: currentSymbolIndex] {
               
                Image(systemName: symbol.symbol)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .transition(.scale)
                Text(symbol.name)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
            }
        }
        .onReceive(timer) { _ in
            withAnimation {
                currentSymbolIndex = (currentSymbolIndex + 1) % oo.data.count
            }
        }
    }
}

// Extensión para acceder al array de forma segura
extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


#Preview {
    SymbolsView()
}


