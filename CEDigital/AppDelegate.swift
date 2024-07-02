//
//  AppDelegate.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/9/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
//import VeridiumCore
//import Veridium4FBiometrics
//import Veridium4FUI


class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?
    var orientationLock = UIInterfaceOrientationMask.all
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setupNavigationColor()
        
        FirebaseConfiguration().setLoggerLevel(FirebaseLoggerLevel.min)
        
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        
        if #available(iOS 13.0, *) {
            // In iOS 13 setup is done in SceneDelegate
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            coordinator = AppCoordinator(window: window!)
            coordinator?.start()
        }
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AppDelegate.applicationWillExpire(notification:)),
                                               name: .appTimeWillExpire,
                                               object: nil
        )
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AppDelegate.applicationDidTimeout(notification:)),
                                               name: .appTimeout,
                                               object: nil
        )
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AppDelegate.applicationClosePopUp(notification:)),
                                               name: .appTimeClosePopUp,
                                               object: nil
        )
        
        
        return true
    }
    
    //https://developer.apple.com/documentation/technotes/tn3106-customizing-uinavigationbar-appearance
    func setupNavigationColor(){
        
        let newNavBarAppearance = customNavBarAppearance()
        
        let appearance = UINavigationBar.appearance()
        //Remove black underline from navigation
        appearance.shadowImage = UIImage()
        appearance.barStyle = UIBarStyle.black
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        appearance.compactAppearance = newNavBarAppearance
        if #available(iOS 15.0, *) {
            appearance.standardAppearance = newNavBarAppearance
            appearance.scrollEdgeAppearance = newNavBarAppearance
    
        }
        
    }
    
    
    func customNavBarAppearance() -> UINavigationBarAppearance {
        let customNavBarAppearance = UINavigationBarAppearance()
        
        // Apply an Accent background.
        customNavBarAppearance.configureWithOpaqueBackground()
        customNavBarAppearance.backgroundColor = UIParameters.COLOR_PRIMARY
        
        // Apply white colored normal and large titles.
        customNavBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        customNavBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        // Apply white color to all the nav bar buttons.
        let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.lightText]
        barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
        barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.white]
        customNavBarAppearance.buttonAppearance = barButtonItemAppearance
        customNavBarAppearance.backButtonAppearance = barButtonItemAppearance
        customNavBarAppearance.doneButtonAppearance = barButtonItemAppearance
        
        return customNavBarAppearance
    }
    
    @objc func applicationWillExpire(notification: NSNotification) {
        
        if  (UIApplication.topTabBarController() is TabBarController) {
            
            let rootViewController = UIApplication.topTabBarController() as! TabBarController
            rootViewController.onSessionWillExpire()
            
            
        }else{
            if let rootViewController = UIApplication.topViewController() {
                
                if(rootViewController is GenericViewController){
                    let viewController = rootViewController as! GenericViewController
                    viewController.onSessionWillExpire()
                    
                }
            }
        }
        
        
    }
    
    @objc func applicationClosePopUp(notification: NSNotification) {
        
        if let rootViewController = UIApplication.topViewController() {
            if(rootViewController is UIAlertController){
                let alertController = rootViewController as! UIAlertController
                alertController.dismiss(animated: true, completion: nil)
                
            }
        }
        
        
    }
    
    @objc func applicationDidTimeout(notification: NSNotification) {
        
        
        if  (UIApplication.topTabBarController() is TabBarController) {
            
            let rootViewController = UIApplication.topTabBarController() as! TabBarController
            rootViewController.onSessionLogout()
            
            
        }else{
            if let rootViewController = UIApplication.topViewController() {
                
                if(rootViewController is GenericViewController){
                    let viewController = rootViewController as! GenericViewController
                    viewController.onSessionLogout()
                    
                }
            }
        }
        
        
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneWillResignActive
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneDidEnterBackground
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneWillEnterForeground
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneDidBecomeActive
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}





