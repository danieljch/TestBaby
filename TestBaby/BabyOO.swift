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
            SymbolsDO(name: "House", symbol: "house.fill"),
            SymbolsDO(name: "Car", symbol: "car.fill"),
            SymbolsDO(name: "Pencil", symbol: "pencil"),
            SymbolsDO(name: "Tree", symbol: "tree.fill"),
            SymbolsDO(name: "Book", symbol: "book.fill"),
            SymbolsDO(name: "Phone", symbol: "phone.fill"),
            SymbolsDO(name: "Bike", symbol: "bicycle.fill"),
            SymbolsDO(name: "Ferry", symbol: "ferry.fill")]
        // Grupo 2: Elementos climáticos
        let group2 = [
            SymbolsDO(name: "Sun", symbol: "sun.max"),
            SymbolsDO(name: "Moon", symbol: "moon"),
            SymbolsDO(name: "Cloud", symbol: "cloud"),
            SymbolsDO(name: "Rain", symbol: "cloud.rain"),
            SymbolsDO(name: "Snow", symbol: "snow"),
            SymbolsDO(name: "Wind", symbol: "wind"),
            SymbolsDO(name: "Tornado", symbol: "tornado"),
            SymbolsDO(name: "Fog", symbol: "cloud.fog"),
        ]

        // Grupo 3: Elementos de animales
        let group3 = [
            SymbolsDO(name: "Dog", symbol: "dog.fill"),
            SymbolsDO(name: "Cat", symbol: "cat.fill"),
            SymbolsDO(name: "Bird", symbol: "bird.fill"),
            SymbolsDO(name: "Fish", symbol: "fish.fill"),
            SymbolsDO(name: "Lizard", symbol: "lizard.fill"),
            SymbolsDO(name: "Ladybug", symbol: "ladybug.fill"),
            SymbolsDO(name: "Rabbit", symbol: "hare.fill"),
            SymbolsDO(name: "Turtle", symbol: "tortoise.fill"),
        ]

        data = group1 + group2 + group3
    }
}


