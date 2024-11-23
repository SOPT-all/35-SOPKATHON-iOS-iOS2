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
        let thirdViewController = UINavigationController(rootViewController: ThirdViewController())
        
        firstViewController.tabBarItem = UITabBarItem(title: "1", image: UIImage(systemName: "house.fill"), tag: 0)
        secondViewController.tabBarItem = UITabBarItem(title: "2", image: UIImage(systemName: "house.fill"), tag: 1)
        thirdViewController.tabBarItem = UITabBarItem(title: "3", image: UIImage(systemName: "house.fill"), tag: 2)
        
        viewControllers = [firstViewController, secondViewController, thirdViewController]
    }

}
