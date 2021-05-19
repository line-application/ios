//
//  Api.swift
//  On line
//
//  Created by Artur Luis on 06/05/21.
//

import Foundation
import Combine
import Amplify
import AWSPluginsCore
import SwiftyRequest

struct Api {
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    func get<ResponsePayload:Codable>(url:String, handler: @escaping (ResponsePayload?) -> Void) {
        let path = "\(API_URL)\(url)"
        print(path)
        Amplify.Auth.fetchAuthSession() { result in
            do {
                let session = try result.get()
                
                // Get cognito user pool token
                if let cognitoTokenProvider = session as? AuthCognitoTokensProvider {
                    let tokens = try cognitoTokenProvider.getCognitoTokens().get()
                    let request = RestRequest(method: .get, url: path)
                    request.headerParameters = ["Authorization":"Bearer \(tokens.idToken)"]
                    request.responseObject { (object:RestResponse<ResponsePayload>) in
                        print(object.result)
                        if let data = object.data {
                            print(data)
                            let result = try? decoder.decode(ResponsePayload.self, from: data)
                            handler(result)
                        }
                    }
                }
            } catch {
                print("Fetch auth session failed with error - \(error)")
            }
        }
        
    }
    
    func post<RequestPayload: Codable, ResponsePayload: Codable>(url:String, data:RequestPayload, handler: @escaping (ResponsePayload?) -> Void) {
        Amplify.Auth.fetchAuthSession() { result in
            do {
                let session = try result.get()
                if let cognitoTokenProvider = session as? AuthCognitoTokensProvider {
                    let tokens = try cognitoTokenProvider.getCognitoTokens().get()
                    let request = RestRequest(method: .post, url: API_URL)
                    request.messageBody = try? JSONEncoder().encode(data)
                    request.headerParameters = ["Authorization":"Bearer \(tokens.idToken)"]
                    
                    request.responseObject { (object:RestResponse<ResponsePayload>) in
                        if let data = object.data {
                            print(data)
                            let result = try? decoder.decode(ResponsePayload.self, from: data)
                            handler(result)
                        }
                    }
                }
            } catch {
                print("Fetch auth session failed with error - \(error)")
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
    
    func patch<RequestPayload: Codable, ResponsePayload: Codable>(url:String, data:RequestPayload ,handler: @escaping (ResponsePayload?) -> Void) {
      
        let path = "\(API_URL)\(url)"
    
        Amplify.Auth.fetchAuthSession() { result in
            do {
                let session = try result.get()
                if let cognitoTokenProvider = session as? AuthCognitoTokensProvider {
                    let tokens = try cognitoTokenProvider.getCognitoTokens().get()
                    let request = RestRequest(method: .patch, url: path)
                    request.headerParameters = ["Authorization":"Bearer \(tokens.idToken)"]
                    print(request.headerParameters)
                    request.messageBody = try? JSONEncoder().encode(data)
                    request.responseObject { (object:RestResponse<ResponsePayload>) in
                        print(object.result)
                        if let data = object.data {
                            let result = try? decoder.decode(ResponsePayload.self, from: data)
                            handler(result)
                        }
                    }
                }
            } catch {
                print("Fetch auth session failed with error - \(error)")
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
