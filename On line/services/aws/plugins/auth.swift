//
//  auth.swift
//  On line
//
//  Created by Artur Luis on 11/05/21.
//

import Foundation
import Amplify

let authBusinessConfiguration = AuthCategoryConfiguration(
    plugins: [
        "awsCognitoAuthPlugin":[
            "IdentityManager": [:],
            "CredentialsProvider": [
                "CognitoIdentity": [
                    "default": [
                        "PoolId": "us-east-1:db27e49a-336c-4510-90b1-b26b56606d6f",
                        "Region": "us-east-1"
                    ]
                ]
            ],
            "CognitoUserPool": [
                "Default": [
                    "PoolId": "us-east-1_u4gY6NnFl",
                    "AppClientId": "1v870km00nhfbrduhlnf6q7cso",
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

let authClientConfiguration = AuthCategoryConfiguration(
    plugins: [
        "awsCognitoAuthPlugin":[
            "IdentityManager": [:],
            "CredentialsProvider": [
                "CognitoIdentity": [
                    "default": [
                        "PoolId": "us-east-1:79f46df2-29a6-4bb0-beb2-8ecdd3fb233e",
                        "Region": "us-east-1"
                    ]
                ]
            ],
            "CognitoUserPool": [
                "Default": [
                    "PoolId": "us-east-1_8sm9anunO",
                    "AppClientId": "5rud3mk6l51ep0dbijippauiid",
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
