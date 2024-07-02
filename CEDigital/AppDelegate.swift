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
import VeridiumCore
import Veridium4FBiometrics
import Veridium4FUI


class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?
    var orientationLock = UIInterfaceOrientationMask.all
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let navigationBarAppearace = UINavigationBar.appearance()
        //Remove black underline from navigation
        navigationBarAppearace.shadowImage = UIImage()
        navigationBarAppearace.barStyle = .blackTranslucent
        navigationBarAppearace.isTranslucent = false
        
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        if #available(iOS 15.0, *){
            
            
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor  = UIParameters.COLOR_PRIMARY
            
            
            navigationBarAppearace.standardAppearance = appearance
            navigationBarAppearace.scrollEdgeAppearance = appearance
            
            
            //navigationBar.standardAppearance = appearance;
            //navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
            
        }else{
            navigationBarAppearace.barTintColor = UIParameters.COLOR_PRIMARY
            navigationBarAppearace.tintColor = .white
            navigationBarAppearace.isTranslucent = false
            
            
            
        }
        
        
        
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
        
        
        
        
        //Veridium
        
        let licenseSDK = "U3OWjUmSSl5aS8vgYYCqEzNBjEWCuiI7xWKApUaKg6u3Xbg35hzdbbgeOWUiwK8+DxvmjywYP4rmOQiZBdDXCXsiZGV2aWNlRmluZ2VycHJpbnQiOiJoSndqbzdjQTZ3bjJTM1F4MktnNlVodjlhZUdvcHBrQzVHd1FQY09hVjRrPSIsImxpY2Vuc2UiOiJFTnNMTUlKUmppS28vR2ZSMGZMTzJIdWJvRmN3RE1vOG1MaS9EbkR5UmE4N093czJCMVRpYzBmcmdRenFlUDNXS0FwMzFLUnBLN2haVDV6ZnRZWmJCbnNpZEhsd1pTSTZJbE5FU3lJc0ltNWhiV1VpT2lKVFJFc2lMQ0pzWVhOMFRXOWthV1pwWldRaU9qRTJOVGcwT1RVeE1Ea3NJbU52YlhCaGJubE9ZVzFsSWpvaVNXNXpiMngxZEdsdmJuTWdMU0JOYVdkeVlXTnBiMjVsY3lJc0ltTnZiblJoWTNSSmJtWnZJam9pUTJGeWJtVjBJRWxrWlc1MGFXUmhaQ0JOYVdkeVlXTnBiMjVsY3lCUVpYTER1aUEwUmtVZ1ZqVWdVSEp2WkhWamRHbHZiaUJ3WlM1bmIySXViV2xuY21GamFXOXVaWE11WTJWa2FXZHBkR0ZzTGtORlJHbG5hWFJoYkNBc2NHVXVaMjlpTG0xcFozSmhZMmx2Ym1WekxtTmxaR2xuYVhSaGJDQWlMQ0pqYjI1MFlXTjBSVzFoYVd3aU9pSnRhV2QxWld3dWFHVnlibUZ1WkdWNlFHbHVjMjlzZFhScGIyNXpMbkJsSWl3aWMzVmlUR2xqWlc1emFXNW5VSFZpYkdsalMyVjVJam9pWXpoc2VrVk5abHBXWXpaSGJGVnBWbVZVZWxOMFUyNUNNRTFqVUhWc1pYSnRXbkoxZFhCbVpucEhiejBpTENKemRHRnlkRVJoZEdVaU9qRTJNakU1TVRVeU1EQXNJbVY0Y0dseVlYUnBiMjVFWVhSbElqb3hOamt3TnpjMk1EQXdMQ0puY21GalpVVnVaRVJoZEdVaU9qRTJPVEV3TXpVeU1EQXNJblZ6YVc1blUwRk5URlJ2YTJWdUlqcG1ZV3h6WlN3aWRYTnBibWRHY21WbFVrRkVTVlZUSWpwbVlXeHpaU3dpZFhOcGJtZEJZM1JwZG1WRWFYSmxZM1J2Y25raU9tWmhiSE5sTENKaWFXOXNhV0pHWVdObFJYaHdiM0owUlc1aFlteGxaQ0k2Wm1Gc2MyVXNJbkoxYm5ScGJXVkZiblpwY205dWJXVnVkQ0k2ZXlKelpYSjJaWElpT21aaGJITmxMQ0prWlhacFkyVlVhV1ZrSWpwbVlXeHpaWDBzSW1WdVptOXlZMlVpT25zaWNHRmphMkZuWlU1aGJXVnpJanBiSW5CbExtZHZZaTV0YVdkeVlXTnBiMjVsY3k1alpXUnBaMmwwWVd3aUxDSndaUzVuYjJJdWJXbG5jbUZqYVc5dVpYTXVZMlZrYVdkcGRHRnNMa05GUkdsbmFYUmhiQ0pkTENKelpYSjJaWEpEWlhKMFNHRnphR1Z6SWpwYlhYMTkifQ=="
        
        let license4FSDK = "ADYrbdBWH1JSfeNC3K5sN8E7bMBas1VBWK2KxrE0Uilu8YdvTwI7guKy1Va8ydSnbYdq+9xiq2YvgFb3ip77C3siZGV2aWNlRmluZ2VycHJpbnQiOiJoSndqbzdjQTZ3bjJTM1F4MktnNlVodjlhZUdvcHBrQzVHd1FQY09hVjRrPSIsImxpY2Vuc2UiOiJmRm04MkRQVzNQMVpwdW5CVk02U3VZZ0I1dWV4SzY5TWFvMEJBOFhjZElKTzRndll4WiswZVcwSHFHY1dnZDdDL3JXSnZ0ektoOUFwd1l4MmUwRUVESHNpZEhsd1pTSTZJa0pKVDB4SlFsTWlMQ0p1WVcxbElqb2lORVlpTENKc1lYTjBUVzlrYVdacFpXUWlPakUyTlRnME9UVXhNRGsyTURBc0ltTnZiWEJoYm5sT1lXMWxJam9pU1c1emIyeDFkR2x2Ym5NZ0xTQk5hV2R5WVdOcGIyNWxjeUlzSW1OdmJuUmhZM1JKYm1adklqb2lRMkZ5Ym1WMElFbGtaVzUwYVdSaFpDQk5hV2R5WVdOcGIyNWxjeUJRWlhMRHVpQTBSa1VnVmpVZ1VISnZaSFZqZEdsdmJpQndaUzVuYjJJdWJXbG5jbUZqYVc5dVpYTXVZMlZrYVdkcGRHRnNMa05GUkdsbmFYUmhiQ0FzY0dVdVoyOWlMbTFwWjNKaFkybHZibVZ6TG1ObFpHbG5hWFJoYkNBaUxDSmpiMjUwWVdOMFJXMWhhV3dpT2lKdGFXZDFaV3d1YUdWeWJtRnVaR1Y2UUdsdWMyOXNkWFJwYjI1ekxuQmxJaXdpYzNWaVRHbGpaVzV6YVc1blVIVmliR2xqUzJWNUlqb2lZemhzZWtWTlpscFdZelpIYkZWcFZtVlVlbE4wVTI1Q01FMWpVSFZzWlhKdFduSjFkWEJtWm5wSGJ6MGlMQ0p6ZEdGeWRFUmhkR1VpT2pFMk1qRTVNVFV5TURBd01EQXNJbVY0Y0dseVlYUnBiMjVFWVhSbElqb3hOamt3TnpjMk1EQXdNREF3TENKbmNtRmpaVVZ1WkVSaGRHVWlPakUyT1RFd016VXlNREF3TURBc0luVnphVzVuVTBGTlRGUnZhMlZ1SWpwbVlXeHpaU3dpZFhOcGJtZEdjbVZsVWtGRVNWVlRJanBtWVd4elpTd2lkWE5wYm1kQlkzUnBkbVZFYVhKbFkzUnZjbmtpT21aaGJITmxMQ0ppYVc5c2FXSkdZV05sUlhod2IzSjBSVzVoWW14bFpDSTZabUZzYzJVc0luSjFiblJwYldWRmJuWnBjbTl1YldWdWRDSTZleUp6WlhKMlpYSWlPbVpoYkhObExDSmtaWFpwWTJWVWFXVmtJanBtWVd4elpYMHNJbVpsWVhSMWNtVnpJanA3SW1KaGMyVWlPblJ5ZFdVc0luTjBaWEpsYjB4cGRtVnVaWE56SWpwMGNuVmxMQ0psZUhCdmNuUWlPblJ5ZFdWOUxDSmxibVp2Y21ObFpGQnlaV1psY21WdVkyVnpJanA3SW0xaGJtUmhkRzl5ZVV4cGRtVnVaWE56SWpwbVlXeHpaWDBzSW5abGNuTnBiMjRpT2lJcUxpb2lmUT09In0="
        
        //FaceTec.sdk.configureLocalization(withTable: "FaceTec", bundle: Bundle.main)
        let sdkStatus:VeridiumLicenseStatus = VeridiumSDK.setup(licenseSDK)
        if(!sdkStatus.initSuccess) {
            NSLog("License: %@", "Invalid License!!")
            VeridiumUtils.alert("Your SDK license is invalid", title: "License")
        }
        if(sdkStatus.isInGracePeriod) {
            NSLog("License: %@", "License expired")
            VeridiumUtils.alert("Your SDK license will expire soon. Please contact your administrator for a new license", title: "License")
        }
        let exportStatus:VeridiumLicenseStatus = VeridiumSDK.shared.setupLib4F(withLicense: license4FSDK)
        if(!exportStatus.initSuccess) {
            NSLog("License 4F: %@", "Invalid License 4F!!")
            VeridiumUtils.alert("Your TouchlessID license is invalid", title: "License 4F")
        }
        if(exportStatus.isInGracePeriod) {
            NSLog("License: %@", "Invalid License 4F!!")
            VeridiumUtils.alert("Your TouchlessID license will expire soon. Please contact your administrator for a new license", title: "License 4F")
        }
        VeridiumSDK.shared.register4FUIExporter()
        VeridiumSDK.shared.register4FUIEnroller()
        VeridiumSDK.shared.register4FUIAuthenticator()
        window = UIWindow(frame: UIScreen.main.bounds)
        print("VeridiumSDK: "+VeridiumSDK.sdkVersion)
        
        return true
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





