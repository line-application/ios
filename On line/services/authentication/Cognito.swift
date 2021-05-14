
//  Authentication.swift
//  On line
//
//  Created by Artur Luis on 05/05/21.
//

import Foundation
import Amplify
import AmplifyPlugins

func cognito(){
    do {
        let auth = AuthCategoryConfiguration(
            plugins: [
                "awsCognitoAuthPlugin":[
                    "CredentialsProvider": [
                        "CognitoIdentity": [
                            "Default": [
                                "PoolId": "us-east-1_7JPA2dsgZ",
                                "Region": "us-east-1"
                            ]
                        ]
                    ],
                    "CognitoUserPool": [
                        "Default": [
                            "PoolId": "us-east-1:6d883f7f-5644-4bcc-86ac-7fbef4330c81",
                            "AppClientId": "1jgski59ous4ee4fs3ctv9vjb0",
                            "Region": "us-east-1"
                        ]
                    ],
                    "Auth": [
                        "Default": [
                            "authenticationFlowType": "USER_PASSWORD_AUTH"
                        ]
                    ]]
            ]
        )
        
        let api = APICategoryConfiguration(plugins: [
            "awsAPIPlugin":[
                "on-line-api":[
                    "endpointType": "REST",
                    "endpoint": "https://mt3bpqe173.execute-api.us-east-1.amazonaws.com/DEVELOPMENT",
                    "region": "us-east-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "YOUR_API_KEY"
                ]
            ]
        ])
        
        let amplifyConfiguration = AmplifyConfiguration(api:api, auth: auth)
        try Amplify.add(plugin: AWSCognitoAuthPlugin())
        try Amplify.add(plugin: AWSAPIPlugin())
        try Amplify.configure(amplifyConfiguration)
        
        print("Amplify configured with auth plugin")
    } catch {
        print("Failed to initialize Amplify with \(error)")
    }
}

