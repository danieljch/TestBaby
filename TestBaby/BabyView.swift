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
    @State private var change = false
    
    let animationDuration: TimeInterval = 3.0
    
    // Configurar el Timer para que se repita cada 3 segundos.
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
   var body: some View {
    VStack {
        if let symbol = oo.data[safe: currentSymbolIndex] {
            Image(systemName: symbol.symbol)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .offset(x: change ? -100 : UIScreen.main.bounds.width - 100 ) // Modificado para iniciar desde la izquierda y moverse hacia la derecha
                .animation(.linear(duration: animationDuration), value: change)
                .opacity(getOpacityEffect(for: currentSymbolIndex))
            
            Text(symbol.name)
                .font(.system(size: 50))
                .foregroundColor(.blue)
                .padding()
                .shadow(color: .black, radius: 3, x: 2, y: 2)
                .onTapGesture {
                    change.toggle()
                }
        }
    }
    .onReceive(timer) { _ in
        withAnimation {
            // Actualizar el índice del símbolo actual para la transición
            currentSymbolIndex = (currentSymbolIndex + 1) % oo.data.count
            
        }
    }
}
    
    private func getOpacityEffect(for index: Int) -> Double {
        let progress = Double(index % 3) / 2.0
        return progress <= 0.5 ? 0.5 + 0.5 * progress : 1.0 - 0.5 * (progress - 0.5)
    }
    
    private func getOffset(for index: Int) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let stepSize = screenWidth / CGFloat(oo.data.count)
        return -screenWidth / 2 + CGFloat(index) * stepSize
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}




#Preview {
    SymbolsView()
}
