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
                    "default": [
                        "PoolId": "us-east-1:c2cd53b5-f853-46cd-af60-e59b8146bec7",
                        "Region": "us-east-1"
                    ]
                ]
            ],
            "CognitoUserPool": [
                "Default": [
                    "PoolId": "us-east-1_eHHZFnoIM",
                    "AppClientId": "5r7sltekifle2pghf189s1kfhc",
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
