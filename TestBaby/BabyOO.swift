//
//  BabyOO.swift
//  TestBaby
//
//  Created by Daniel Jesus Callisaya Hidalgo on 29/1/24.
//


import Observation


@Observable
class SymbolsOO {
    var data: [SymbolsDO] = []

    init() {
        loadSymbols()
    }

    func loadSymbols() {
        // Grupo 1: Objetos comunes
        let group1 = [
            SymbolsDO(name: "Casa", symbol: "house"),
            SymbolsDO(name: "Auto", symbol: "car"),
            SymbolsDO(name: "Lápiz", symbol: "pencil"),
        ]

        // Grupo 2: Elementos climáticos
        let group2 = [
            SymbolsDO(name: "Sol", symbol: "sun.max"),
            SymbolsDO(name: "Luna", symbol: "moon"),
            SymbolsDO(name: "Nube", symbol: "cloud"),
        ]

        data = group1 + group2
    }
}


