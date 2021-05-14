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
                        "PoolId": "us-east-1:9e243e49-f702-4dcb-9b70-ab2b19af6a44",
                        "Region": "us-east-1"
                    ]
                ]
            ],
            "CognitoUserPool": [
                "Default": [
                    "PoolId": "us-east-1_sRBMjUSVs",
                    "AppClientId": "3oqk1re1tqjqdroel24m3lop0p",
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
