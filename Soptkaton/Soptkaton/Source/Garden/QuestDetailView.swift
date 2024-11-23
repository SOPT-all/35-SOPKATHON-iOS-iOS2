//
//  QuestDetailView.swift
//  Soptkaton
//
//  Created by HanJW on 11/24/24.
//

import SwiftUI

struct QuestDetailView: View {
    var body: some View {
        VStack {
            ZStack{
                VStack{
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray)
                        .frame(width: 327, height: 505)
                        .padding()
                }
                
                ZStack {
                    Capsule()
                        .fill(Color(.jungleMainColor(.main)))
                        .frame(width: 87, height: 31)
                    
                    Text("QLabel")
                        .foregroundStyle(Color.white)
                        .font(.jungleHeading(.heading3b20))
                }
                .offset(y: -185)
                
                Text("sample")
                    .offset(y: -170)

                HStack{
                    Text("sample")
                    Text("sample")
                }
                
                HStack{
                    Text("sample")
                    Text("sample")
                }
                
                Text("sample")

                
            }
            
            Button(action: {
                print("testing")
            }, label: {
                Text("수행하기")
                    .padding()
                    .background(Capsule().strokeBorder())
            })
        }
    }
}

extension Font {
    static func pretendardFont(weight: FontWeight, ofSize fontSize: CGFloat) -> Font {
        return Font.custom(weight.rawValue, size: fontSize)
    }
    
    static func jungleHeading(_ style: Heading) -> Font {
        switch style {
        case .heading1b24: return pretendardFont(weight: .pretendardBold, ofSize: 24)
        case .heading2b22: return pretendardFont(weight: .pretendardBold, ofSize: 22)
        case .heading3b20: return pretendardFont(weight: .pretendardBold, ofSize: 20)
        case .heading4b18: return pretendardFont(weight: .pretendardBold, ofSize: 18)
        }
    }
    
    static func jungleBody(_ style: Body) -> Font {
        switch style {
        case .body1b16: return pretendardFont(weight: .pretendardBold, ofSize: 16)
        case .body1m16: return pretendardFont(weight: .pretendardMedium, ofSize: 16)
        case .body2b14: return pretendardFont(weight: .pretendardBold, ofSize: 14)
        case .body2m14: return pretendardFont(weight: .pretendardMedium, ofSize: 14)
        }
    }
    
    static func jungleCaption(_ style: Caption) -> Font {
        switch style {
        case .caption1b12: return pretendardFont(weight: .pretendardBold, ofSize: 12)
        case .caption1m12: return pretendardFont(weight: .pretendardMedium, ofSize: 12)
        }
    }
}

#Preview {
    QuestDetailView()
}
