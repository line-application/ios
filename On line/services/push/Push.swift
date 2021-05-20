//
//  Push.swift
//  On line
//
//  Created by Artur Luis on 19/05/21.
//

import Foundation
import UserNotifications
import Foundation
import SwiftUI

struct Push {
    static func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    static func persistTokenOnApi(_ token: String){
        let pushNoficitaionTokenApi = PushNotificationTokenApi()
        pushNoficitaionTokenApi.create(token: token, handler: {response in print(response)})
    }
    
    private static func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
            
        }
    }
}
