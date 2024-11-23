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

        let firstViewController = UINavigationController(rootViewController: HomeViewController())
        let secondViewController = UINavigationController(rootViewController: SecondViewController())

        firstViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "ic_home_gray7"),
            tag: 0
        )
        secondViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "ic_user_gray2"),
            tag: 1
        )

        viewControllers = [firstViewController, secondViewController]
        setupTabBarStyle()
    }

    private func setupTabBarStyle() {
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()

        let customBackground = UIView(frame: tabBar.bounds)
        customBackground.backgroundColor = UIColor.jungleSystemColor(.white)
        customBackground.layer.cornerRadius = 16
        customBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        customBackground.layer.masksToBounds = true

        let borderLayer = CAShapeLayer()
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: 16))
        path.addArc(withCenter: CGPoint(x: 16, y: 16),
                    radius: 16,
                    startAngle: .pi,
                    endAngle: 3 * .pi / 2,
                    clockwise: true)

        path.addLine(to: CGPoint(x: customBackground.frame.width - 16, y: 0))
        path.addArc(withCenter: CGPoint(x: customBackground.frame.width - 16, y: 16),
                    radius: 16,
                    startAngle: 3 * .pi / 2,
                    endAngle: 0,
                    clockwise: true)

        borderLayer.path = path.cgPath
        borderLayer.strokeColor = UIColor.jungleGrayScale(.gray9).cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = 1

        customBackground.layer.shadowColor = UIColor.black.cgColor
        customBackground.layer.shadowOffset = CGSize(width: 0, height: -3)
        customBackground.layer.shadowRadius = 6
        customBackground.layer.shadowOpacity = 0.1

        tabBar.insertSubview(customBackground, at: 0)
        customBackground.layer.addSublayer(borderLayer)
    }
}
