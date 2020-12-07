//
//  File.swift
//  Insta-X
//
//  Created by Youssef Osama on 27/11/2020.
//

import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = true
        tabBar.isSpringLoaded = true
        
        let homeVC = HomeTableViewViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "Group -3"), selectedImage: #imageLiteral(resourceName: "Group 7"))
        
        let notsVC = NotificationController()
        notsVC.tabBarItem = UITabBarItem(title: "Notifications", image: #imageLiteral(resourceName: "Path 2"), selectedImage: #imageLiteral(resourceName: "Path -1"))
        
        let chatVC = UIViewController()
        chatVC.view.backgroundColor = .yellow
        chatVC.tabBarItem = UITabBarItem(title: "Chat", image: #imageLiteral(resourceName: "Path 453"), selectedImage: #imageLiteral(resourceName: "Path -2"))
        
        let accVC = UIViewController()
        accVC.view.backgroundColor = .black
        accVC.tabBarItem = UITabBarItem(title: "Account", image: #imageLiteral(resourceName: "Path 6"), selectedImage: #imageLiteral(resourceName: "Path 896"))
        
        viewControllers = [homeVC, notsVC, chatVC, accVC]
        
    }
    
}



