
//  UserType.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import Foundation

enum UserType {
    case BUSINESS
    case CLIENT
    case LOADING
    
    var stringForm:String {
        switch self.self {
        case UserType.BUSINESS:
            return "business"
        case  UserType.CLIENT:
            return "client"
        case UserType.LOADING:
            return "loading"
        }
    }
}
