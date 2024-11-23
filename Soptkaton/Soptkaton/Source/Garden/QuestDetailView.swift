//
//  QuestDetailView.swift
//  Soptkaton
//
//  Created by HanJW on 11/24/24.
//

import SwiftUI

struct QuestDetailView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(.jungleGradientColor(.start)), Color(.jungleGradientColor(.end))], startPoint: .topLeading, endPoint: .bottomTrailing)

            VStack {
                ZStack{
                    VStack{
                        Image("img_card")
                            .frame(width: 327, height: 505)
                            .padding([.bottom])
                    }
                    
                    VStack {
                        Text("체력 단련")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(Color(.jungleMainColor(.main)))
                            )
                            .foregroundStyle(Color(.jungleSystemColor(.white)))
                            .font(.jungleBody(.body1b16))
                            .offset(y: -185)
                        
                        Text("정글에서 강인한 체력은 필수!")
                            .foregroundStyle(Color(.jungleSystemColor(.white)))
                            .font(.jungleHeading(.heading3b20))
                            .offset(y: -170)
                    }
                    
                    HStack{
                        ZStack {
                            Image("img_score_bg")
                            
                            HStack {
                                Text("경험치")
                                Text("|")
                                Text("+"+"40")
                            }
                        }
                        .foregroundStyle(Color(.jungleMainColor(.sub)))
                        .font(.jungleBody(.body2m14))
                        .rotationEffect(.degrees(12))
                        .offset(y: -2)
                        
                        ZStack {
                            Image("img_middle_shape")
                            
                            Text("중급")
                                .rotationEffect(.degrees(-12))
                        }
                        .foregroundStyle(Color(.jungleMainColor(.sub)))
                        .font(.jungleBody(.body1b16))
                        .offset(y: -30)
                    }
                    
                    Text("빌딩숲이 가득한 세상 속에서 두 발로 걸으며 체력을 단련해보자! 계단 50개를 올라가다 보면 머리도 맑아질 거야.")
                        .font(.jungleBody(.body2m14))
                        .foregroundStyle(Color(.jungleSystemColor(.white)))
                        .frame(width: 279, height: 54)
                        .offset(y: 134)
                }
                
                Button(action: {
                }, label: {
                    Text("도전하기")
                })
                .frame(width: 327, height: 56)
                .background(Color(.jungleMainColor(.main)))
                .foregroundStyle(Color(.jungleSystemColor(.white)))
                .font(.jungleBody(.body1b16))
                .cornerRadius(12)
            }
        }
        .ignoresSafeArea()
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
