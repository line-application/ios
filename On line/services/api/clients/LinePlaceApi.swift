//
//  LinePlaceApi.swift
//  On line
//
//  Created by Artur Luis on 06/05/21.
//

import Foundation

enum LinePlaceRemoveType {
    case AsClient, AsBusiness
}

struct LinePlaceApi {
    let api = Api()
    
    //client
    func create(linePlace: LinePlaceModel, handler: @escaping (TimeEstimativeModel?) -> Void) {
        api.post(url: "/line-place", data: linePlace, handler: handler)
    }
    
    //client, business
    func remove(type: LinePlaceRemoveType, email: String, handler: @escaping (LinePlaceModel?) -> Void) {
        //clientEmail and businessEmail should be sent trought the header auth token.
        var url: String {
            switch type {
            case .AsBusiness :
                return "/line-place/business?action=remove"
            case .AsClient :
                return "/line-place/client"
            }
        }
        
        struct RemoveLinePlaceRequest: Codable {
            let email: Email
        }
        api.patch(url: url, data: RemoveLinePlaceRequest(email: email), handler: handler)
    }
    
    //business
    func confirm(clientEmail: Email, handler: @escaping (LinePlaceModel?) -> Void) {
        struct ConfirmLinePlaceRequest: Codable {
            let clientEmail: Email
        }
        api.patch(url: "/line-place/business?action=confirm", data: ConfirmLinePlaceRequest(clientEmail: clientEmail), handler: handler)
    }
}
