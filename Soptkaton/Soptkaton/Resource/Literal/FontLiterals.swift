//
//  FontLiterals.swift
//  Soptkaton
//
//  Created by 조호근 on 11/22/24.
//

import UIKit

enum FontWeight: String {
    
    case pretendardBold = "Pretendard-Bold"
    case pretendardMedium = "Pretendard-Medium"
    
}

enum Heading {
    
    case heading1b24
    case heading2b22
    case heading3b20
    case heading4b18
    
}

enum Body {
    
    case body1b16
    case body1m16
    case body2b14
    case body2m14
    
}

enum Caption {
    
    case caption1b12
    case caption1m12
    
}

extension UIFont {
    
    static func pretendardFont(weight: FontWeight, ofSize fontSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: weight.rawValue, size: fontSize) else { fatalError("Font not found") }
        return font
    }
    
    static func jungleHeading(_ style: Heading) -> UIFont {
        switch style {
        case .heading1b24: return pretendardFont(weight: .pretendardBold, ofSize: 24)
        case .heading2b22: return
            pretendardFont(weight: .pretendardBold, ofSize: 22)
        case .heading3b20: return pretendardFont(weight: .pretendardBold, ofSize: 20)
        case .heading4b18: return pretendardFont(weight: .pretendardBold, ofSize: 18)
        }
    }
    
    static func jungleBody(_ style: Body) -> UIFont {
        switch style {
        case .body1b16: return pretendardFont(weight: .pretendardBold, ofSize: 16)
        case .body1m16: return pretendardFont(weight: .pretendardMedium, ofSize: 16)
        case .body2b14: return pretendardFont(weight: .pretendardBold, ofSize: 14)
        case .body2m14: return pretendardFont(weight: .pretendardMedium, ofSize: 14)
        }
    }
    
    static func jungleCaption(_ style: Caption) -> UIFont {
        switch style {
        case .caption1b12: return pretendardFont(weight: .pretendardBold, ofSize: 12)
        case .caption1m12: return pretendardFont(weight: .pretendardMedium, ofSize: 12)
        }
    }
    
}
