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
                        "PoolId": "us-east-1:cda5e9a7-9345-4ba1-a4f8-379e19a6720e",
                        "Region": "us-east-1"
                    ]
                ]
            ],
            "CognitoUserPool": [
                "Default": [
                    "PoolId": "us-east-1_Y4npjeREs",
                    "AppClientId": "530mr9tpn6q48uokdpjdr3bq4f",
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
