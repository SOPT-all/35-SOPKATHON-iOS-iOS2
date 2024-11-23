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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        
    }
    
    private func setHierarchy() {
        view.addSubview(storyLabel)
    }
    
    private func setLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        storyLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    
    }

}
