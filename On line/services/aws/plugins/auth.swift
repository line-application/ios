//
//  auth.swift
//  On line
//
//  Created by Artur Luis on 11/05/21.
//

import Foundation
import Amplify

let authConfiguration = AuthCategoryConfiguration(
    plugins: [
        "awsCognitoAuthPlugin":[
            "IdentityManager": [:],
            "CredentialsProvider": [
                "CognitoIdentity": [
                    "Default": [
                        "PoolId": "us-east-1:98c746e9-c257-4309-b056-f9cad7bceeb1",
                        "Region": "us-east-1"
                    ]
                ]
            ],
            "CognitoUserPool": [
                "Default": [
                    "PoolId": "us-east-1_QverS6VBZ",
                    "AppClientId": "5pu13fa7i3v8cnb9eefs1k3q39",
                    "Region": "us-east-1"
                ]
            ],
            "Auth": [
                "Default": [
                    "authenticationFlowType": "USER_SRP_AUTH"
                ]
            ]]
    ]
)
