//
//  apiGateway.swift
//  On line
//
//  Created by Artur Luis on 11/05/21.
//

import Foundation
import Amplify

let apiConfiguration = APICategoryConfiguration(plugins: [
    "awsAPIPlugin":[
        "on-line-api":[
            "endpointType": "REST",
            "endpoint": "https://ph1o9i0fak.execute-api.us-east-1.amazonaws.com/DEVELOPMENT",
            "region": "us-east-1",
            "authorizationType": "AMAZON_COGNITO_USER_POOLS"
        ]
    ]
])

let API_URL = "https://ph1o9i0fak.execute-api.us-east-1.amazonaws.com/DEVELOPMENT"

