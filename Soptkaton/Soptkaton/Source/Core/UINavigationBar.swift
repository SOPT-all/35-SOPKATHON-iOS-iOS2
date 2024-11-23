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
}
