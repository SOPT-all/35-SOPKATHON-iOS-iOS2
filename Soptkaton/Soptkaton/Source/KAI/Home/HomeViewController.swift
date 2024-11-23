//
//  HomeViewController.swift
//  Soptkaton
//
//  Created by 최주리 on 11/23/24.
//

import UIKit

import SnapKit
import Then

class HomeViewController: UIViewController {
    
    private let levelLabel = UILabel().then {
        $0.text = "Lv. 2"
        $0.font = .jungleHeading(.heading3b20)
        $0.textColor = .jungleGrayScale(.gray1)
    }
    
    private let expProgressImage = UIImageView().then {
        $0.image = .rectangle5
    }
    
    private let expProgressLabel = UILabel().then {
        $0.text = "85/135"
        $0.font = .jungleBody(.body2m14)
        $0.textColor = .jungleGrayScale(.gray1)
    }
    
    private let characterImage = UIImageView().then {
        $0.image = .character
    }
    
    private let questTitleLabel = UILabel().then {
        $0.text = "생존 전략"
        $0.font = .jungleHeading(.heading2b22)
        $0.textColor = .jungleGrayScale(.gray1)
    }
    
    private let questView = QuestView().then {
        $0.configure()
        $0.makeCornerRadius(cornerRadius: 16)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        setHierarchy()
        setLayout()
    }
    

    private func setHierarchy() {
        self.view.addSubviews(
            levelLabel,
            expProgressImage,
            expProgressLabel,
            characterImage,
            questTitleLabel,
            questView
        )
    }
    
    private func setLayout() {
        levelLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.equalToSuperview().inset(30)
        }
        
        expProgressImage.snp.makeConstraints {
            $0.top.equalTo(levelLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(23)
            $0.width.equalTo(300)
            $0.height.equalTo(13)
        }
        
        expProgressLabel.snp.makeConstraints {
            $0.centerY.equalTo(expProgressImage)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        characterImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(expProgressImage.snp.bottom).offset(100)
            $0.width.equalTo(144)
            $0.height.equalTo(224)
        }
        
        questTitleLabel.snp.makeConstraints {
            $0.top.equalTo(characterImage.snp.bottom).offset(143)
            $0.leading.equalToSuperview().inset(32)
        }
        
        questView.snp.makeConstraints {
            $0.top.equalTo(questTitleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(72)   
        }
    }

}

#if DEBUG
import SwiftUI

#Preview {
    HomeViewController()
}

#endif
