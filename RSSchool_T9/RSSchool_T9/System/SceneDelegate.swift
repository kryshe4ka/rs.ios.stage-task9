//
// 📰 🐸
// Project: RSSchool_T9
//
// Author: Uladzislau Volchyk
// On: 23.07.21
//
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else {
            fatalError("LOL, be careful, drink some water")
        }
        UIView.appearance().tintColor = UIColor(named: "FF0000");
        window = UIWindow(windowScene: scene)
        window?.rootViewController = self.rootViewController()
        window?.makeKeyAndVisible()
    }
    
    func rootViewController() -> UIViewController {
        let commonVC = CommonCollectionViewController()
        
        let itemsViewController = UINavigationController(rootViewController: commonVC)
        let settingsVC =  SettingsViewController()
        settingsVC.delegateKL = commonVC
        settingsVC.delegateColor = commonVC
        let settingsViewController = UINavigationController(rootViewController: settingsVC)
        itemsViewController.tabBarItem = UITabBarItem.init(title: "Items", image:UIImage.init(systemName: "square.grid.2x2"), tag: 0)
        settingsViewController.tabBarItem = UITabBarItem.init(title: "Settings", image: UIImage.init(systemName: "gear"), tag: 1)
        
        let tabBarController = UITabBarController.init()
        tabBarController.viewControllers = [itemsViewController, settingsViewController]
        tabBarController.customizableViewControllers = nil
        return tabBarController
    }
}

extension UINavigationController {
    static var drawOFF = false
}

