//
//  AppDelegate.swift
//  Insta-X
//
//  Created by Youssef Osama on 09/11/2020.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let sp = UIStoryboard(name: "AuthSB", bundle: .main)
        let vc = sp.instantiateInitialViewController()
        
        let Tabar = TabBar()
        let Homecollection = HomeTableViewViewController()
    
        
        let usertoken = UserDefaults.standard.string(forKey: "accessToken")
        
     if usertoken == nil {
          window?.rootViewController = vc
        }else{
            window?.rootViewController = Tabar
        }
        

        

        IQKeyboardManager.shared.enable = true
        return true
    }
}
