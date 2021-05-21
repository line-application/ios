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
    @StateObject var pushNotificationData = PushNotificationDataState.shared
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
    
    static func handlePushNotification(action: String, state: PushNotificationDataState) {
        switch action {
        case "HANDLE_BUSINESS_PUSH":
            handleBusinessPush(state)
        case "HANDLE_CLIENT_INVOKE":
            handleClientInvoke()
        case "HANDLE_CLIENT_REMOVAL":
            handleClientRemoval()
        default:
            return;
        }
    }
    
    static func handleBusinessPush(_ state:PushNotificationDataState) {
        state.refetchClientList = true
        print("handleBusinessPush()")
    }
    
    static func handleClientInvoke() {
        //fetch line status
        print("handleClientInvoke()")
    }
    
    static func handleClientRemoval() {
        //remove client line status
        print("handleClientRemoval()")
    }
    
}
