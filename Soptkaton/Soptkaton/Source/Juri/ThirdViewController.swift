//
//  ThirdViewController.swift
//  Soptkaton
//
//  Created by 최주리 on 11/23/24.
//

import UIKit
import SnapKit
import Then

class ThirdViewController: UIViewController {

    private let storyLabel = UILabel().then {
        $0.text = "안녕하시렵니까? 스토리텔링 화면입니다만.. 무얼 더 해야하죠...."
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setHierarchy()
        setLayout()
        setupTapGesture()
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }
    
    @objc private func screenTapped() {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }
    
    private func setHierarchy() {
        view.addSubview(storyLabel)
    }
    
    private func setLayout() {
        storyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    
    }
}
