//
//  configureAmplify.swift
//  On line
//
//  Created by Artur Luis on 11/05/21.
//

import Foundation
import Foundation
import Amplify
import AmplifyPlugins

struct AWS {
    static func configure(){
        do {
            let amplifyConfiguration = AmplifyConfiguration(api:apiConfiguration, auth: authConfiguration)
            // Amplify.Logging.logLevel = .verbose
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSAPIPlugin())
            try Amplify.configure(amplifyConfiguration)
            
            print("Amplify configured with auth plugin")
        } catch {
            print("Failed to initialize Amplify with \(error)")
        }
    }
    
    
}
