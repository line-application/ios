//
//  AppDelegate.swift
//  On line
//
//  Created by Artur Luis on 05/05/21.
//

import Foundation
import SwiftUI
import Amplify
import AmplifyPlugins

class AppDelegate: NSObject, UIApplicationDelegate {
    @StateObject var pushNotificationData = PushNotificationDataState.shared
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        AWS.configure()
        Push.registerForPushNotifications()
        //        Amplify.Auth.signOut()
        UNUserNotificationCenter.current().delegate = self

        
        let notificationPayload = UserDefaults.standard.string(forKey: "TEST_1")
        print(notificationPayload ?? "jhgj")
        return false
    }
    
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        Push.persistTokenOnApi(token)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("response",response)
    }
    // Receive displayed notifications for iOS 10 or later devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print("Receive notification in the foreground \(userInfo)")
//        let pref = UserDefaults.init(suiteName: "group.id.gits.notifserviceextension")
//        pref?.set(userInfo, forKey: "NOTIF_DATA")
        //        guard let vc = UIApplication.shared.windows.first?.rootViewController as? ViewController else { return }
        //        vc.handleNotifData()
        
//        guard let vc = UIApplication.shared.rootViewController as? ContentView else { return }
//        vc.processPushPayload()
        pushNotificationData.title = "success"
        completionHandler([.alert, .badge, .sound])
    }
}

extension UIApplication {
    var currentKeyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter { $0.isKeyWindow }
            .first
    }
    
    var rootViewController: UIViewController? {
        currentKeyWindow?.rootViewController
    }
    
    
}
