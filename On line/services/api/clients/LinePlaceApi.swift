//
//  LinePlaceApi.swift
//  On line
//
//  Created by Artur Luis on 06/05/21.
//

import Foundation
import Amplify
enum LinePlaceRemoveType {
    case AsClient, AsBusiness
}

struct LinePlaceApi {
    let api = Api()
    
    func list(invoked: Bool,handler:@escaping ([LinePlaceModel]?) -> Void){
        let url = "/line-place?invoked=\(invoked ? "true": "false")"
        api.get(url: url, handler: handler)
    }
    
    //client
    func create(linePlace: LinePlaceModel, handler: @escaping (TimeEstimativeModel?) -> Void) {
        api.post(url: "/line-place", data: linePlace, handler: handler)
    }
    
    //client, business
    func remove(type: LinePlaceRemoveType, email: String, handler: @escaping (LinePlaceModel?) -> Void) {
        //clientEmail and businessEmail should be sent trought the header auth token.
        var queryStrings: [String : String]? {
            switch type {
            case .AsBusiness :
                return ["action":"remove","entity":"business"]
            case .AsClient :
                return ["action":"remove","entity":"client"]
            }
        }
        
        
        struct RemoveLinePlaceRequest: Codable {
            let email: Email
        }
        api.patch(url: "/line-place", data: RemoveLinePlaceRequest(email: email), queryStrings: queryStrings, handler: handler)
    }
    
    //business
    func confirm(clientEmail: Email, handler: @escaping (LinePlaceModel?) -> Void) {
        struct ConfirmLinePlaceRequest: Codable {
            let clientEmail: Email
        }
        api.patch(url: "/line-place", data: ConfirmLinePlaceRequest(clientEmail: clientEmail), queryStrings:  ["action":"confirm","entity":"business"], handler: handler)
    }
}
