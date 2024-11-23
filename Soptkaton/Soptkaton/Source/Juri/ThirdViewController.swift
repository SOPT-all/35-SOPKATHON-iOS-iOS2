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

    private let storyImageView = UIImageView().then {
        $0.image = .imgOnboarding
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
        view.addSubview(storyImageView)
    }
    
    private func setLayout() {
        storyImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    
    }
}
