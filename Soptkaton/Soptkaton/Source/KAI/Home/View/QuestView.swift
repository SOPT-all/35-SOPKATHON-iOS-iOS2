//
//  QuestView.swift
//  Soptkaton
//
//  Created by 조호근 on 11/23/24.
//

import UIKit

import SnapKit
import Then

class QuestView: UIView {
    
    private let questTitleLabel = UILabel().then {
        $0.font = .jungleHeading(.heading2b22)
        $0.textColor = .jungleGrayScale(.gray1)
    }
    
    private let challengeLabel = UILabel().then {
        $0.font = .jungleBody(.body2m14)
        $0.textColor = .jungleGrayScale(.gray5)
        $0.textAlignment = .center
        $0.backgroundColor = .jungleGrayScale(.gray9)
        $0.makeBorder(width: 1, color: .jungleGrayScale(.gray8))
        $0.makeCornerRadius(cornerRadius: 6)
    }
    
    private let questSubTitleLabel = UILabel().then {
        $0.font = .jungleBody(.body2m14)
        $0.textColor = .jungleGrayScale(.gray1)
    }
    
    private let nextButton = UIButton().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .jungleGrayScale(.gray5)
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        self.addSubviews(
            questTitleLabel,
            challengeLabel,
            questSubTitleLabel,
            nextButton
        )
    }
    
    private func setLayout() {
        questTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        
        challengeLabel.snp.makeConstraints {
            $0.centerY.equalTo(questTitleLabel)
            $0.leading.equalTo(questTitleLabel.snp.trailing).offset(10)
            $0.width.equalTo(36)
            $0.height.equalTo(22)
        }
        
        questSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(challengeLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(16)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(32)
        }
    }
    
    func configure() {
        questTitleLabel.text = "체력 단련"
        challengeLabel.text = "중급"
        questSubTitleLabel.text = "정글에서 강인한 체력은 필수!"
    }
    
}

#if DEBUG
import SwiftUI

#Preview {
    
    QuestView()
}

#endif
