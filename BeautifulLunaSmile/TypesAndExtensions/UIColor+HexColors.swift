//
//  UIColor+HexColors.swift
//  BeautifulLunaSmile
//
//  Created by Mosquito1123 on 13/07/2019.
//  Copyright © 2019 Cranberry. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func hexColor(_ string: String) -> UIColor {
        let set = CharacterSet.whitespacesAndNewlines
        var colorString = string.trimmingCharacters(in: set).uppercased()
        
        if (colorString.hasPrefix("#")) {
            let index = colorString.index(after: colorString.startIndex)
            colorString = String(colorString[index..<colorString.endIndex])
        }
        
        assert(colorString.count == 6, "expected hexidecimal color string")
        
        var rgbValue: UInt32 = 0
        Scanner(string: colorString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue:  CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
extension DateFormatter {
    public static var fullDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d yyyy 'at' h:mm a z"
        return formatter
    }()
}
