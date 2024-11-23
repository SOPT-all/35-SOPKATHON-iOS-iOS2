//
//  UINavigationBar.swift
//  Soptkaton
//
//  Created by 이지훈 on 11/24/24.
//

import UIKit

extension UIViewController {
    func setupNavigationLogo() {
        let logoImage = UIImage(named: "header_logo")
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.contentMode = .scaleAspectFit
        
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: 124, height: 40)
        
        logoImageView.frame = CGRect(x: 24, y: 10, width: 100, height: 30)
        
        containerView.addSubview(logoImageView)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: containerView)
    }
    
    func setupCustomBackButton() {
        navigationItem.hidesBackButton = true
        
        let backButton = UIButton(type: .custom)
        let backImage = UIImage(named: "ic_arrow_left_gray2")
        backButton.setImage(backImage, for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        containerView.addSubview(backButton)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: containerView)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
