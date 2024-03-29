//
//  LunarViewModel.swift
//  BeautifulLunaSmile
//
//  Created by Mosquito1123 on 13/07/2019.
//  Copyright © 2019 Cranberry. All rights reserved.
//

import Foundation

struct LunarViewModel {
    
    private let moon: Moon
    
    init(moon: Moon) {
        self.moon = moon
    }
    
    var icon: String {
        return moon.percent.symbolForMoon
    }
    
    var phase: String {
        return moon.phase.capitalized
    }
    
    var rise: String {
        guard let rise = moon.rise else { return "---" }
        return DateFormatter.fullDate.string(from: rise)
    }
    
    var set: String {
        guard let set = moon.set else { return  "---" }
        return DateFormatter.fullDate.string(from: set)
    }
    
    var age: String {
        let length = 27.3
        let age = ((moon.percent * 0.01) * length) * 100.0
        
        switch age {
        case 1:
            let day = String(format: "%.1f", age)
            return "\(day) day old"
        default:
            let days = String(format: "%.1f", age)
            return "\(days) days old"
        }
    }
    
    var illumination: String {
        let percent = String(format: "%.1f", moon.percent * 100)
        return "\(percent)% complete"
    }
}
