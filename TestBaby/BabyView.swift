//
//  BabyView.swift
//  TestBaby
//
//  Created by Daniel Jesus Callisaya Hidalgo on 26/1/24.
//

// View
import SwiftUI

struct BabyViewView: View {
    @State private var oo = BabyViewOO()
    
    var body: some View {
        List(oo.data) { datum in
            Text(datum.name)
        }
        .task {
            oo.fetch()
        }
    }
}

#Preview {
    BabyViewView()
}

// Observable Object
import Observation
import SwiftUI

@Observable
class BabyViewOO {
    var data: [BabyViewDO] = []
    
    func fetch() {
        data = [BabyViewDO(name: "Datum 1"),
                BabyViewDO(name: "Datum 2"),
                BabyViewDO(name: "Datum 3")]
    }
}

// Data Object
import Foundation

struct BabyViewDO: Identifiable {
    let id = UUID()
    var name: String
}
