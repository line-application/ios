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
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        AWS.configure(auth: authClientConfiguration)
        
        return false
        
    }
}

