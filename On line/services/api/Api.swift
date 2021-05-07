//
//  Api.swift
//  On line
//
//  Created by Artur Luis on 06/05/21.
//

import Foundation
import Combine
import Amplify

struct Api {
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    func get<ResponsePayload:Codable>(url:String, handler: @escaping (ResponsePayload?) -> Void) {
        let request: RESTRequest = RESTRequest(path: url)
        
        Amplify.API.get(request: request) { result in
            switch result {
            case .success(let data):
                let result = try? decoder.decode(ResponsePayload.self, from: data)
                handler(result)
            case .failure(let apiError):
                print(apiError)
                handler(nil)
            }
        }
    }
    
    func post<RequestPayload: Codable, ResponsePayload: Codable>(url:String, data:RequestPayload, handler: @escaping (ResponsePayload?) -> Void) {
        let request: RESTRequest = RESTRequest(path: url, body: try? encoder.encode(data))
        Amplify.API.post(request: request) {result in
            switch result {
            case .success(let data):
                let result = try? decoder.decode(ResponsePayload.self, from: data)
                handler(result)
                
            case .failure(let apiError):
                print(apiError)
                handler(nil)
            }
        }
    }
    
    func put<RequestPayload: Codable, ResponsePayload: Codable>(url:String, data:RequestPayload, handler: @escaping (ResponsePayload?) -> Void) {
        let request: RESTRequest = RESTRequest(path: url, body: try? encoder.encode(data) )
        Amplify.API.put(request: request) {result in
            switch result {
            case .success(let data):
                let result = try? decoder.decode(ResponsePayload.self, from: data)
                handler(result)
                
            case .failure(let apiError):
                print(apiError)
                handler(nil)
            }
        }
    }
    
    func patch<RequestPayload: Codable, ResponsePayload: Codable>(url:String, data:RequestPayload, handler: @escaping (ResponsePayload?) -> Void) {
        let request: RESTRequest = RESTRequest(path: url, body: try? encoder.encode(data) )
        Amplify.API.patch(request: request) {result in
            switch result {
            case .success(let data):
                let result = try? decoder.decode(ResponsePayload.self, from: data)
                handler(result)
                
            case .failure(let apiError):
                print(apiError)
                handler(nil)
            }
        }
    }
    
    func delete<ResponsePayload: Codable>(url:String, handler: @escaping (ResponsePayload?) -> Void) {
        let request: RESTRequest = RESTRequest(path: url)
        Amplify.API.delete(request: request) {result in
            switch result {
            case .success(let data):
                let result = try? decoder.decode(ResponsePayload.self, from: data)
                handler(result)
                
            case .failure(let apiError):
                print(apiError)
                handler(nil)
            }
        }
    }
}
