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
import Kingfisher

class HomeViewController: UIViewController {
    
    private let homeService: HomeServiceProtocol = HomeService()
        
    private let containerView = UIView()
    
    private let characterImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .jungleGrayScale(.gray6)
        $0.makeCornerRadius(cornerRadius: 16)
        $0.clipsToBounds = true
    }
    
    private let levelLabel = UILabel().then {
        $0.font = .jungleBody(.body1m16)
        $0.textColor = .jungleSystemColor(.white)
        $0.textAlignment = .center
    }
    
    private let expLabel = UILabel().then {
        $0.font = .jungleBody(.body1m16)
        $0.textColor = .jungleMainColor(.main)
        $0.textAlignment = .center
    }
    
    private let expImageView = UIImageView().then {
        $0.image = .progressbar70
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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        setHierarchy()
        setLayout()
        setupQuestView()
        setupNavigationLogo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.isHidden = false
        
        fetchHomeData()
    }
    
    // MARK: - Network
    
    private func fetchHomeData() {
        Task {
            do {
                let questData = try await homeService.fetchQuestData()
                await MainActor.run {
                    updateUI(with: questData)
                }
            } catch {
                print("Error fetching home data:", error)
            }
        }
    }
    
    private func updateUI(with data: QuestResponse) {
        levelLabel.text = data.member_level
        expLabel.text = data.member_exp
        
        if let imageURL = URL(string: data.member_img_url) {
            let options: KingfisherOptionsInfo = [
                .cacheOriginalImage,
                .transition(.fade(0.2)),
                .scaleFactor(UIScreen.main.scale),
                .forceTransition,
                .keepCurrentImageWhileLoading
            ]
            
            let width = characterImage.bounds.width > 0 ? characterImage.bounds.width : UIScreen.main.bounds.width - 48
            let height = characterImage.bounds.height > 0 ? characterImage.bounds.height : 437
            
            let processor = ResizingImageProcessor(referenceSize: CGSize(width: width, height: height))
                |> DownsamplingImageProcessor(size: CGSize(width: width, height: height))
            
            characterImage.kf.indicatorType = .activity
            characterImage.kf.setImage(
                with: imageURL,
                placeholder: UIImage(color: .jungleGrayScale(.gray6)),
                options: options + [.processor(processor)]) { result in
                    switch result {
                    case .success(let value):
                        print("Image successfully loaded. Size: \(value.image.size)")
                    case .failure(let error):
                        print("Error loading image: \(error.localizedDescription)")
                    }
                }
        }
        
        questView.configure(
            title: data.quest_name,
            level: data.quest_level,
            subtitle: data.quest_summary
        )
    }
    // MARK: - UI Setup
    
    private func setHierarchy() {
        self.containerView.addSubviews(
            characterImage,
            levelLabel,
            expLabel,
            expImageView,
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
        
        expImageView.snp.makeConstraints {
            $0.top.equalTo(expLabel.snp.bottom).offset(14)
            $0.trailing.equalToSuperview().inset(14)
        }
        
        questTitleLabel.snp.makeConstraints {
            $0.top.equalTo(characterImage.snp.bottom).offset(44)
            $0.leading.equalToSuperview()
        }
        
        questView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-22)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(82)
        }
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

// MARK: - Navigation

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

// alert

extension HomeViewController: CustomAlertDelegate {
    func willDismissAlert() {
        fetchHomeData()
    }
    
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
            alertVC.delegate = self  
            alertVC.experienceText = 40
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            topController?.present(alertVC, animated: true)
        }
    }
}

extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
