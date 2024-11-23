//
//  ColorLiterals.swift
//  Soptkaton
//
//  Created by 조호근 on 11/22/24.
//

import UIKit

enum GrayScale: String {
    
    case gray1 = "#171719"
    case gray2 = "#46474C"
    case gray3 = "#5A5C63"
    case gray4 = "#878A93"
    case gray5 = "#989BA2"
    case gray6 = "#AEB0B6"
    case gray7 = "#C2C4C8"
    case gray8 = "#DBDCDF"
    case gray9 = "#F7F7F8"
    
}

enum SystemColor: String {
    
    case white = "#FFFFFF"
    case red = "#EC0F29"
    
}

enum MainColor: String {
    
    case main = "#00C875"
    case sub = "#80EC7E"
    
}

extension UIColor {
    
    static func jungleGrayScale(_ style: GrayScale) -> UIColor {
        guard let color = UIColor(hexCode: style.rawValue) else { fatalError("UIColor init failed") }
        return color
    }
    
    static func jungleSystemColor(_ style: SystemColor) -> UIColor {
        guard let color = UIColor(hexCode: style.rawValue) else { fatalError("UIColor init failed") }
        return color
    }
    
    static func jungleMainColor(_ style: MainColor) -> UIColor {
        guard let color = UIColor(hexCode: style.rawValue) else { fatalError("UIColor init failed") }
        return color
    }
    
}

extension UIColor {
    
    convenience init?(hexCode: String) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        guard let validHexCodeCount = hexFormatted.getValidHexDigits() else {
            fatalError("Invalid hex code: \(hexFormatted)")
        }
        
        var rgbValue: UInt64 = 0
        var alpha: UInt64 = 255
        if validHexCodeCount == 6 {
            Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        } else if validHexCodeCount == 8 {
            Scanner(string: String(hexFormatted.prefix(6))).scanHexInt64(&rgbValue)
            Scanner(string: String(hexFormatted.suffix(2))).scanHexInt64(&alpha)
        }
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat((alpha & 0xFF)) / 255.0)
    }
    
}
