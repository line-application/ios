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
            "endpoint": "https://pp3tmfk1aj.execute-api.us-east-1.amazonaws.com/DEVELOPMENT",
            "region": "us-east-1",
            "authorizationType": "API_KEY",
            "apiKey": "YOUR_API_KEY"
        ]
    ]
])
