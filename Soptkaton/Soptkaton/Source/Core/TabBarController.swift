//
//  TabBarController.swift
//  Soptkaton
//
//  Created by 조호근 on 11/22/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstViewController = UINavigationController(rootViewController: QuestDetailViewController())
        let secondViewController = UINavigationController(rootViewController: SecondViewController())
      //  let thirdViewController = UINavigationController(rootViewController: ThirdViewController())
        
        firstViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_home_gray7"), tag: 0)
        secondViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_user_gray2"), tag: 1)
    
        viewControllers = [firstViewController, secondViewController]
        
        setupTabBarStyle()
    }
    
    private func setupTabBarStyle() {
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        
        let customBackground = UIView()
        customBackground.backgroundColor = .white
        customBackground.frame = tabBar.bounds
        customBackground.layer.cornerRadius = 16
        customBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        customBackground.layer.masksToBounds = true
        
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 0, y: 0, width: customBackground.frame.width, height: 1)
        borderLayer.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.973, alpha: 1).cgColor
        customBackground.layer.addSublayer(borderLayer)
        
        customBackground.layer.shadowColor = UIColor.black.cgColor
        customBackground.layer.shadowOffset = CGSize(width: 0, height: -3)
        customBackground.layer.shadowRadius = 6
        customBackground.layer.shadowOpacity = 0.1
        
        tabBar.insertSubview(customBackground, at: 0)
    }
}
