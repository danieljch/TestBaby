//
//  BabyOO.swift
//  TestBaby
//
//  Created by Daniel Jesus Callisaya Hidalgo on 29/1/24.
//


import Observation

@Observable
class SymbolsOO {
    var data: [SymbolDO] = [
        SymbolDO(name: "star.fill"),
        SymbolDO(name: "heart.fill"),
        SymbolDO(name: "house.fill"),
        SymbolDO(name: "gearshape.fill"),
        SymbolDO(name: "person.fill")
    ]
    var currentSymbolIndex = 0

    func nextSymbol() {
        currentSymbolIndex = (currentSymbolIndex + 1) % data.count
    }

    var currentSymbol: SymbolDO? {
        return data.isEmpty ? nil : data[currentSymbolIndex]
    }
}

