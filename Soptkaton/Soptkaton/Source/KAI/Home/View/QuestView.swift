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
    
    private let imageContainerView = UIView().then {
        $0.backgroundColor = .jungleMainColor(.main)
        $0.makeCornerRadius(cornerRadius: 23)
    }
    
    private let keyLogoImageView = UIImageView().then {
        $0.image = .icKeyWhite
        $0.contentMode = .center
    }
    
    private let questTitleStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }
    
    private let questTitleLabel = UILabel().then {
        $0.font = .jungleBody(.body1b16)
        $0.textColor = .jungleGrayScale(.gray1)
        $0.textAlignment = .center
    }
    
    private let labelContainerView = UIView().then {
        $0.backgroundColor = .jungleMainColor(.sub)
        $0.makeCornerRadius(cornerRadius: 6)
    }
    
    private let levelLabel = UILabel().then {
        $0.font = .jungleBody(.body2m14)
        $0.textColor = .jungleMainColor(.main)
        $0.textAlignment = .center
    }
    
    private let questSubTitleLabel = UILabel().then {
        $0.font = .jungleBody(.body2m14)
        $0.textColor = .jungleGrayScale(.gray5)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .jungleGrayScale(.gray9)
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        imageContainerView.addSubview(keyLogoImageView)
        
        labelContainerView.addSubview(levelLabel)
        
        questTitleStackView.addArrangedSubviews(
            questTitleLabel,
            labelContainerView
        )
        
        self.addSubviews(
            imageContainerView,
            questTitleStackView,
            questSubTitleLabel
        )
    }
    
    private func setLayout() {
        imageContainerView.snp.makeConstraints {
            $0.size.equalTo(46)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12)
        }
        
        keyLogoImageView.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.center.equalTo(imageContainerView)
        }
        
        labelContainerView.snp.makeConstraints {
            $0.width.equalTo(36)
            $0.height.equalTo(22)
        }
        
        levelLabel.snp.makeConstraints {
            $0.center.equalTo(labelContainerView)
        }
        
        questTitleStackView.snp.makeConstraints {
            $0.top.equalTo(imageContainerView.snp.top).inset(1.5)
            $0.leading.equalTo(imageContainerView.snp.trailing).offset(12)
        }
        
        questSubTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(imageContainerView.snp.bottom).inset(1.5)
            $0.leading.equalTo(questTitleStackView.snp.leading)
        }
    }
    
    func configure(title: String, level: String, subtitle: String) {
        questTitleLabel.text = title
        levelLabel.text = level
        questSubTitleLabel.text = subtitle
    }
    
}
