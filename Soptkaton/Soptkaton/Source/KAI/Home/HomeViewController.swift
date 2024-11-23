//
//  HomeViewController.swift
//  Soptkaton
//
//  Created by 최주리 on 11/23/24.
//

import UIKit
import SwiftUI

import SnapKit
import Then

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션 바 보이기 설정
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.isHidden = false
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
    
    private func configure() {
        levelLabel.text = "레벨 1"
        expLabel.text = "70/100"
        
        questView.configure(
            title: "체력 단련",
            level: "고급",
            subtitle: "정글에서 강인한 체력은 필수!"
        )
    }
    
    private func setupQuestView() {
        setupQuestViewTapGesture()
    }
    
    private func setupQuestViewTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(questViewTapped))
        questView.addGestureRecognizer(tapGesture)
        questView.isUserInteractionEnabled = true
    }
    
    @objc private func questViewTapped() {
         pushToQuestDetailView()
     }
}


extension HomeViewController {
    private func pushToQuestDetailView() {
        let questDetailView = QuestDetailView(onPhotoTaken: { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.showCustomAlert()
            }
        })
        let hostingController = UIHostingController(rootView: questDetailView)
        
        hostingController.navigationItem.hidesBackButton = true
        setupCustomBackButton(for: hostingController)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        hostingController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(hostingController, animated: true)
    }
    
    private func setupCustomBackButton(for viewController: UIViewController) {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(customBackButtonTapped), for: .touchUpInside)
        
        let backBarButton = UIBarButtonItem(customView: backButton)
        viewController.navigationItem.leftBarButtonItem = backBarButton
    }
    
    @objc private func customBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension HomeViewController {
    private func showCustomAlert() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            var topController = window.rootViewController
            while let presentedViewController = topController?.presentedViewController {
                topController = presentedViewController
            }
            
            if let navigationController = topController as? UINavigationController {
                topController = navigationController.topViewController
            }
            
            let alertVC = CustomAlertViewController()
            alertVC.experienceText = 40
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            topController?.present(alertVC, animated: true)
        }
    }
}
