//
//  Baby.swift
//  TestBaby
//
//  Created by Daniel Jesus Callisaya Hidalgo on 26/1/24.
//

// View
import SwiftUI

struct BabyView: View {
    @State private var oo = BabyOO()
    
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
    BabyView()
}

// Observable Object
import Observation
import SwiftUI

@Observable
class BabyOO {
    var data: [BabyDO] = []
    
    func fetch() {
        data = [BabyDO(name: "Datum 1"),
                BabyDO(name: "Datum 2"),
                BabyDO(name: "Datum 3")]
    }
}

// Data Object
import Foundation

struct BabyDO: Identifiable {
    let id = UUID()
    var name: String
}
