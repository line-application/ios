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

struct CreateLinePlaceRequest:Codable {
    var businessEmail: String
    var peopleInLine: Int
}

struct FindLinePlaceResponse:Codable {
    var linePlace: LinePlaceModel?
    var business: BusinessModel?
}

struct LinePlaceApi {
    let api = Api()
    
    func find(handler:@escaping (FindLinePlaceResponse?) -> Void) {
        api.get(url:"/line-place-status", handler: handler)
    }
    
    func list(invoked: Bool,handler:@escaping ([LinePlaceModel]?) -> Void){
        let url = "/line-place?invoked=\(invoked ? "true": "false")"
        api.get(url: url, handler: handler)
    }
    
    //client
    func create(linePlace: CreateLinePlaceRequest, handler: @escaping (TimeEstimativeModel?) -> Void) {
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
        api.patch(url: "/line-place?action=remove&entity=client", data: RemoveLinePlaceRequest(email: email), handler: handler)
    }
    
    //business
    func confirm(clientEmail: Email, handler: @escaping (LinePlaceModel?) -> Void) {
        struct ConfirmLinePlaceRequest: Codable {
            let email: Email
        }
        api.patch(url: "/line-place?action=confirm&entity=business", data: ConfirmLinePlaceRequest(email:clientEmail), handler: handler)
    }
}
