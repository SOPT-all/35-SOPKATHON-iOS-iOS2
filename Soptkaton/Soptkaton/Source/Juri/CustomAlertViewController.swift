//
//  CustomAlertViewController.swift
//  Soptkaton
//
//  Created by 최주리 on 11/23/24.
//

import UIKit

final class CustomAlertViewController: UIViewController {
    
    //MARK: - UI Properties

    private let alertView = UIView().then {
        $0.backgroundColor = .jungleSystemColor(.white)
        $0.layer.cornerRadius = 16
    }
    private let titleLabel = UILabel().then {
        $0.text = "생존 성공"
        $0.font = .jungleHeading(.heading4b18)
        $0.textColor = .jungleGrayScale(.gray1)
    }
    private let descriptionLabel = UILabel().then {
        $0.font = .jungleBody(.body1b16)
        $0.numberOfLines = 2
        $0.textColor = .jungleGrayScale(.gray3)
    }
    private lazy var imageView = UIImageView().then {
        $0.image = .imgPopupItem
        $0.contentMode = .scaleAspectFit
    }
    private lazy var okButton = UIButton().then {
        $0.setTitle("완료하기", for: .normal)
        $0.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        $0.titleLabel?.font = .jungleBody(.body1b16)
        $0.setTitleColor(.jungleSystemColor(.white), for: .normal)
        $0.backgroundColor = .jungleMainColor(.main)
        $0.layer.cornerRadius = 16
    }
    
    //MARK: - Properties
    
    var experienceText: Int = 0 {
        didSet {
            descriptionLabel.text = "경험치 + \(experienceText) 점을 획득했습니다.\n정글 탈출에 한 발자국 더 가까이!"
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.5)

        setHierarchy()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //TODO: API 불러오기?? experience 받아와서 적용하기
    }
    
    private func setHierarchy() {
        view.addSubview(alertView)
        alertView.addSubviews(
            titleLabel,
            descriptionLabel,
            imageView,
            okButton
        )
    }
    
    private func setLayout() {
        alertView.snp.makeConstraints {
            $0.height.equalTo(420)
            $0.width.equalTo(311)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(169)
            $0.width.equalTo(279)
        }
        
        okButton.snp.makeConstraints {
            //TODO: 이미지 생기면 다시 설정하기
            $0.bottom.equalToSuperview().inset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.width.equalTo(279)
            $0.height.equalTo(56)
        }
        
    }
    
    @objc
    private func okButtonTapped() {
        self.dismiss(animated: true)
    }
    
}
