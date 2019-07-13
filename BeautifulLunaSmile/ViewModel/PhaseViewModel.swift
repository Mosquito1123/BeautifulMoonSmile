//
//  PhaseViewModel.swift
//  BeautifulLunaSmile
//
//  Created by Mosquito1123 on 13/07/2019.
//  Copyright © 2019 Cranberry. All rights reserved.
//

import Foundation
struct PhaseViewModel {
    
    private let phase: Phase
    
    init(phase: Phase) {
        self.phase = phase
    }
    
    var icon: String {
        return phase.name.symbolForMoon
    }
    
    var date: String {
        return DateFormatter.fullDate.string(from: phase.date)
    }
}
