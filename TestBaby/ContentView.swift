//
//  ContentView.swift
//  TestBaby
//
//  Created by Daniel Jesus Callisaya Hidalgo on 24/1/24.
//

import SwiftUI

struct ContentView: View {
    let symbols: [String] = ["globe", "heart", "star", "moon", "sun", "cloud", "bolt", "leaf"]
    var body: some View {
        VStack {
            List {
                ForEach(0..<8) { index in
                    
                    Image(systemName: symbols[index])
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Hola, mundo! \(index)")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
