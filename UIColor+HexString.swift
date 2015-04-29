//
//  UIColor+HexString.swift
//  UIColor+HexString
//
//  Created by Alex Littlejohn on 2015/04/29.
//  Copyright (c) 2015 zero. All rights reserved.
//


import UIKit

private func extractColorComponent(colorString: String, start: Int, length: Int) -> CGFloat {
    let substring = colorString.subString(start, length: length)
    let fullHex = length == 2 ? substring : substring + substring
    var hexComponent:CUnsignedInt = 0
    NSScanner(string: fullHex).scanHexInt(&hexComponent)
    return CGFloat(Int(hexComponent) / Int(255))
}

extension UIColor {
    convenience init(hexString: String) {
        let colorString = hexString.stringByReplacingOccurrencesOfString("#", withString: "", options: nil, range: nil).uppercaseString
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        switch count(colorString) {
        case 3:
            red = extractColorComponent(colorString, 0, 1)
            green = extractColorComponent(colorString, 1, 1)
            blue = extractColorComponent(colorString, 2, 1)
            alpha = 1.0
        case 4:
            red = extractColorComponent(colorString, 0, 1)
            green = extractColorComponent(colorString, 1, 1)
            blue = extractColorComponent(colorString, 2, 1)
            alpha = extractColorComponent(colorString, 3, 1)
        case 6:
            red = extractColorComponent(colorString, 0, 2)
            green = extractColorComponent(colorString, 2, 2)
            blue = extractColorComponent(colorString, 4, 2)
            alpha = 1.0
        case 8:
            red = extractColorComponent(colorString, 0, 2)
            green = extractColorComponent(colorString, 2, 2)
            blue = extractColorComponent(colorString, 4, 2)
            alpha = extractColorComponent(colorString, 6, 2)
            
        default:
            fatalError("Color value \(hexString) is invalid.  It should be a hex value of the form #RBG, #RGBA, #RRGGBB, or #RRGGBBAA")
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}