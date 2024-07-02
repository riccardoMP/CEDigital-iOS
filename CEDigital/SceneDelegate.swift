//
//  SceneDelegate.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/9/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
        appWindow.windowScene = windowScene
        
        coordinator = AppCoordinator(window: appWindow)
        coordinator!.start()
        
        
        window = appWindow
        
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Not called under iOS 12 - See AppDelegate applicationDidBecomeActive
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Not called under iOS 12 - See AppDelegate applicationWillResignActive
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Not called under iOS 12 - See AppDelegate applicationWillEnterForeground
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Not called under iOS 12 - See AppDelegate applicationDidEnterBackground
    }
}
