//
//  NotificationService.swift
//  NotificationService
//
//  Created by Artur Luis on 20/05/21.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title) [Modified] \(request.content.userInfo["msg"] as? String ?? "test1")"
            // Save notification data to UserDefaults
            let data = bestAttemptContent.userInfo as NSDictionary
            
            UserDefaults.standard.set(data, forKey: "NOTIF_DATA")
            UserDefaults.standard.set(request.content.userInfo["msg"] as? String ?? "test1", forKey: "TEST_1")
//            UserDefaults.standard.synchronize()
            contentHandler(bestAttemptContent)
        } else {
            contentHandler(request.content)
        }
    }
    
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
}
