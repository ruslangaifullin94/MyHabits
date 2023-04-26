//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Руслан Гайфуллин on 13.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        func createHabitsViewController() -> UINavigationController {
            let habitsViewController = HabitsViewController()
            
            habitsViewController.title = "Cегодня"
            habitsViewController.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(named: "habitsBar"), tag: 0)
            return UINavigationController(rootViewController: habitsViewController)
        }
        
        func createInfoViewController() -> UINavigationController {
            let infoViewController = InfoViewController()
            infoViewController.title = "Информация"
            infoViewController.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
            return UINavigationController(rootViewController: infoViewController)
        }
        
        func createTabBarController() -> UITabBarController {
            let tabBarController = UITabBarController()
            let controllers = [createHabitsViewController(),createInfoViewController()]
            tabBarController.viewControllers = controllers
            tabBarController.tabBar.tintColor = UIColor(named: "purpleColor")
            return tabBarController
        }
        
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        window.rootViewController = createTabBarController()
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

