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
    }
    
    //임시
    private lazy var button = UIButton().then {
        $0.setTitle("alert !!! ", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        
        //임시
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    // 임시
    @objc
    private func buttonTapped() {
        let viewController = CustomAlertViewController()
        viewController.experienceText = 40
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
    
    private func setHierarchy() {
        view.addSubviews(storyLabel, button)
    }
    
    private func setLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        storyLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        // 임시
        button.snp.makeConstraints {
            $0.bottom.equalTo(safeArea.snp.bottom).inset(100)
            $0.centerX.equalToSuperview()
        }
    }

}
