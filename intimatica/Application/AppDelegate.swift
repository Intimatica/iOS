//
//  AppDelegate.swift
//  intimatica
//
//  Created by Andrey RustFox on 7/13/21.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import Firebase
import FirebaseRemoteConfig

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        
        let attributes = [NSAttributedString.Key.font: UIFont.rubik(fontSize: .regular, fontWeight: .bold)]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        registerPushNotifications()
        initRemoteConfig()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { data in
            String(format: "%02.2hhx", data)
        }.joined()

        print("Device Token: \(token)")
        PushTokenKeeper.sharedInstance.token = token
    }
    
    func registerPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, _ in
                print("Permission granted: \(granted)")
                
                guard granted else { return }
                self?.getNotificationSettings()
            }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current()
            .getNotificationSettings { settings in
                print("Notification settings: \(settings)")
                
                guard settings.authorizationStatus == .authorized else { return }
                
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
    }
    
    func initRemoteConfig() {
//        let settings = RemoteConfigSettings()
//        settings.minimumFetchInterval = 0
//        RemoteConfig.remoteConfig().configSettings = settings
        
        RemoteConfig.remoteConfig().setDefaults(fromPlist: "AppDefaults")
        
        RemoteConfig.remoteConfig().fetch {[weak self] (status, error) -> Void in
            guard let self = self else { return }
            
            if status == .success {
//                print("Config fetched!")
                RemoteConfig.remoteConfig().activate { [weak self] changed, error in
                    self?.bindRemoteConfig2AppConstants()
                }
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        }
        
        bindRemoteConfig2AppConstants()
    }
    
    func bindRemoteConfig2AppConstants() {
        guard
            let serverURL = RemoteConfig.remoteConfig().configValue(forKey: "serverURL").stringValue
        else {
            fatalError("Failed to init app default paramets")
        }
        
        AppConstants.serverURL = serverURL
        AppConstants.displayPremiumButton = RemoteConfig.remoteConfig().configValue(forKey: "displayPremiumButton").boolValue
    }
}

