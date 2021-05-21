//
//  PushNotificationTokenApi.swift
//  On line
//
//  Created by Artur Luis on 19/05/21.
//

import Foundation

struct CreatePushNoficationTokenRequest: Codable {
    let token: String
}

struct CreatePushNotificationTokenResponse: Codable {
    let msg: String
}

struct PushNotificationTokenApi {
    let api = Api()
    
    func create(token: String, handler:@escaping (CreatePushNotificationTokenResponse?) -> Void) {
        api.post(url: "/push-notification-token", data: CreatePushNoficationTokenRequest(token: token), handler: handler)
    }
}
