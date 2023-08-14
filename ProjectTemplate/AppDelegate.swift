//
//  AppDelegate.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

//import RealmSwift
import Reachability
import SwiftDate
import UIKit
import UserNotifications
import AVFoundation
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var reachability: Reachability?
    
    lazy var notifCenter = NotifCenterManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // MARK: - For YPImagePicker
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = Colors.UI.paleBlack
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        UIBarButtonItem.appearance().tintColor = .systemBlue
        
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : Colors.UI.paleBlack
            ]
            navigationBarAppearance.backgroundColor = Colors.UI.paleBlack
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance

            let tabBarApperance = UITabBarAppearance()
            tabBarApperance.configureWithOpaqueBackground()
            tabBarApperance.backgroundColor = Colors.UI.paleBlack
            UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
            UITabBar.appearance().standardAppearance = tabBarApperance
            UITabBar.appearance().isTranslucent = false
        }
        
        // MARK: Push Notification
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (granted, error) in
            if let error = error {
                NSLog("PUSH NOTIFICATION ERROR:: " + error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                  UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        
        // MARK: Realm
//        let configCheck = Realm.Configuration()
//        do {
//            let fileUrlIs = try schemaVersionAtURL(configCheck.fileURL!)
//            if (fileUrlIs != 0) {
//                let config = Realm.Configuration(
//                    schemaVersion: fileUrlIs,
//                    migrationBlock: { migration, oldSchemaVersion in
//                        if (oldSchemaVersion < fileUrlIs) {
//                            // Nothing to do!
//                        }
//                    })
//                Realm.Configuration.defaultConfiguration = config
//            } else {
//                let schemaVersion = String((UIDevice.appVersion?.replacingOccurrences(of: ".", with: "") ?? "0") + (UIDevice.appBuildNumber ?? "0"))
//                let config = Realm.Configuration(
//                    schemaVersion: UInt64(Int(schemaVersion) ?? 0),
//                    migrationBlock: { migration, oldSchemaVersion in
//                        if (oldSchemaVersion < UInt64((Int(schemaVersion) ?? 0) + 1)) {
//                            // Nothing to do!
//                        }
//                    })
//                Realm.Configuration.defaultConfiguration = config
//            }
//        } catch  {
//            print(error)
//        }
//
//        // MARK: Reachability
//        /// Start notifier in MainController, and stop notifier after logging out
//        reachability = Reachability()
//        try? reachability?.startNotifier()
//
//        // MARK: SwiftDate
//        SwiftDate.defaultRegion = Region(calendar: Calendars.gregorian, zone: Zones.asiaJakarta, locale: Locales.indonesian)
        
        // MARK: AVFoundation
        try? AVAudioSession.sharedInstance().setMode(.videoChat)
        try? AVAudioSession.sharedInstance().setCategory(.playAndRecord,
                                                         options: [.allowBluetooth, .allowBluetoothA2DP])
        
        initRootView()
        
        return true
    }
    
    func initRootView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ViewController()) //RootController()
        window?.makeKeyAndVisible()
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("AppDelegate. didReceive: \(notification)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("AppDelegate. didReceiveRemoteNotification: \(userInfo)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //        NotifCenterManager.post(HandlePushNotif, from: nil, payload: userInfo)
        print("AppDelegate. didReceiveRemoteNotification2: \(userInfo)")
        
        //you can custom redirect to chatRoom
        
        let userInfoJson = JSON(arrayLiteral: userInfo)[0]
        if let payload = userInfo["payload"] as? [String: Any] {
            if let payloadData = payload["payload"] {
                let jsonPayload = JSON(arrayLiteral: payload)[0]
                
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        guard let dict: [AnyHashable: Any] = userInfo["custom"] as? [AnyHashable : Any] else { return }
        do {
            window?.rootViewController = RootController()
            window?.makeKeyAndVisible()
            let currentUiViewController = self.window?.rootViewController ?? RootController()
            
        }
        catch {
            print(error)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //let userInfo = notification.request.content.userInfo
        //NotifCenterManager.post(HandlePushNotif, from: nil, payload: userInfo)
        completionHandler([.alert, .badge, .sound])
    }
}

