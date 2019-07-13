//
//  String+WeatherIcons.swift
//  BeautifulLunaSmile
//
//  Created by Mosquito1123 on 13/07/2019.
//  Copyright © 2019 Cranberry. All rights reserved.
//

import Foundation

extension String {
    
    var symbolForMoon: String {
        switch self {
            
            // Aeris Weather API
            
        case "new moon":
            return "\u{f095}"
        case "first quarter":
            return "\u{f09c}"
        case "full moon":
            return "\u{f0a3}"
        case "last quarter":
            return "\u{f0aa}"
            
        default:
            return "X"
        }
    }
}
