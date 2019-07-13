//
//  Date+Lunar.swift
//  BeautifulLunaSmile
//
//  Created by Mosquito1123 on 13/07/2019.
//  Copyright © 2019 Cranberry. All rights reserved.
//

import Foundation

extension Date {
    private var julianDate: Double {
        let epochJulianDate = 2440587.5
        return epochJulianDate + timeIntervalSince1970 / 86400
    }
    
    var moonPhase: Double {
        let lunarSynodicPeriod = 29.53059
        let phase = (julianDate + 4.867) / lunarSynodicPeriod
        return (phase - floor(phase))
    }
}
