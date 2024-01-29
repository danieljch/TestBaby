//
//  BabyOO.swift
//  TestBaby
//
//  Created by Daniel Jesus Callisaya Hidalgo on 29/1/24.
//

import Foundation

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
