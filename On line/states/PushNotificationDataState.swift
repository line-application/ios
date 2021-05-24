//
//  PushNotificationDataState.swift
//  On line
//
//  Created by Artur Luis on 20/05/21.
//

import Foundation


class PushNotificationDataState:ObservableObject {
    @Published var title: String = "error"
    @Published var refetchClientList: Bool = false
    @Published var clientExitLine: Bool = false
    // 1
    static let shared = PushNotificationDataState()
    // 2
    private init() { }
    
    func handleData() {
        
    }
}
