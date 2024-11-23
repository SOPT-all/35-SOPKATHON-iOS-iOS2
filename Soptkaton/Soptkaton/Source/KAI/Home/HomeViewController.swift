//
//  HomeViewController.swift
//  Soptkaton
//
//  Created by 최주리 on 11/23/24.
//

import UIKit

import SnapKit
import Then
import SwiftUI

class HomeViewController: UIViewController {
    
    private let containerView = UIView()
    
    private let characterImage = UIImageView().then {
        $0.image = UIImage(systemName: "person")
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .jungleGrayScale(.gray6)
        $0.makeCornerRadius(cornerRadius: 16)
    }
    
    private let levelLabel = UILabel().then {
        $0.font = .jungleBody(.body1m16)
        $0.textColor = .jungleGrayScale(.gray1)
        $0.textAlignment = .center
    }
    
    private let expLabel = UILabel().then {
        $0.font = .jungleBody(.body1m16)
        $0.textColor = .jungleMainColor(.main)
        $0.textAlignment = .center
    }
    
    private let questTitleLabel = UILabel().then {
        $0.text = "오늘의 탈출 전략"
        $0.font = .jungleHeading(.heading2b22)
        $0.textColor = .jungleGrayScale(.gray1)
        $0.textAlignment = .center
    }
    
    private let questView = QuestView().then {
        $0.makeCornerRadius(cornerRadius: 16)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        setHierarchy()
        setLayout()
        configure()
        setupQuestView()  

        setupNavigationLogo()
    }

    private func setHierarchy() {
        self.containerView.addSubviews(
            characterImage,
            levelLabel,
            expLabel,
            questTitleLabel,
            questView
        )
        
        self.view.addSubview(containerView)
    }
    
    private func setLayout() {
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
    
        characterImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(22)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(437)
        }
        
        levelLabel.snp.makeConstraints {
            $0.top.equalTo(characterImage.snp.top).inset(20)
            $0.leading.equalToSuperview().inset(14)
        }
        
        expLabel.snp.makeConstraints {
            $0.top.equalTo(levelLabel.snp.top)
            $0.trailing.equalToSuperview().inset(14)
        }
        
        questTitleLabel.snp.makeConstraints {
            $0.top.equalTo(characterImage.snp.bottom).offset(44)
            $0.leading.equalToSuperview()
        }
        
        questView.snp.makeConstraints {
            $0.top.equalTo(questTitleLabel.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(82)
        }
    }

    func configure() {
        levelLabel.text = "레벨 1"
        expLabel.text = "70/100"
        
        questView.configure(
            title: "체력 단련",
            level: "고급",
            subtitle: "정글에서 강인한 체력은 필수!"
        )
    }
}

// HomeViewController.swift에 추가될 부분

extension HomeViewController {
    private func setupQuestViewTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(questViewTapped))
        questView.addGestureRecognizer(tapGesture)
        questView.isUserInteractionEnabled = true
    }
    
    @objc private func questViewTapped() {
        let questDetailView = QuestDetailView()
        let hostingController = UIHostingController(rootView: questDetailView)
        
        // Navigation 설정
        hostingController.modalPresentationStyle = .fullScreen
        
        // 네비게이션으로 push
        if let navigationController = self.navigationController {
            navigationController.pushViewController(hostingController, animated: true)
        } else {
            // 네비게이션 컨트롤러가 없는 경우 모달로 표시
            present(hostingController, animated: true)
        }
    }
    
    // viewDidLoad()에서 호출되어야 하는 설정
    private func setupQuestView() {
        setupQuestViewTapGesture()
    }
}

// QuestView.swift에 추가될 부분 (기존 QuestView 클래스에 추가)
extension QuestView {
    override func layoutSubviews() {
        super.layoutSubviews()
        isUserInteractionEnabled = true
    }
}
