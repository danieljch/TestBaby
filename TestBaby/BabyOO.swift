//
//  BabyOO.swift
//  TestBaby
//
//  Created by Daniel Jesus Callisaya Hidalgo on 29/1/24.
//


import Observation

@Observable
class SymbolsOO {
    var data: [SymbolDO] = [ SymbolDO(name: "star.fill", color: .yellow), SymbolDO(name: "heart.fill", color: .red), SymbolDO(name: "house.fill", color: .green), SymbolDO(name: "gearshape.fill", color: .gray), SymbolDO(name: "person.fill", color: .blue) ]
    var currentSymbolIndex = 0

    func nextSymbol() {
        currentSymbolIndex = (currentSymbolIndex + 1) % data.count
    }

    func addSymbol(name: String) { data.append(SymbolDO(name: name)) }

    var currentSymbol: SymbolDO? {
        return data.isEmpty ? nil : data[currentSymbolIndex]
    }
}

