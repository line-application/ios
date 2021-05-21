
//  Authentication.swift
//  On line
//
//  Created by Artur Luis on 05/05/21.
//

import Foundation
import Amplify
import AmplifyPlugins

enum SignUpResponseTypes {
    case ERROR, SUCCESS, CONFIRM_ACCOUNT
}

struct Authentication {
    static func signIn(username: String, password: String, handler:@escaping (Bool)->Void) {
        print("username: \(username)")
        print("password: \(password)")
        
        Amplify.Auth.signIn(username: username, password: password) { result in
            switch result {
            case .success(let success):
                print(success)
                
                handler(true)
            case .failure(let error):
                print(error)
                handler(false)
            }
        }
        
    }
    
    static func signUp(name: String, password: String, email: String, phoneNumber: String? = nil, userType: UserType, highestTableCapacity:Int? = nil, description:String? = nil, address:String? = nil,handler:@escaping (SignUpResponseTypes)->Void) {
        print(userType.stringForm)
        
        var userAttributes = [
            AuthUserAttribute(.name, value: name),
            AuthUserAttribute(.email, value: email),
            AuthUserAttribute(.custom("userType"), value: userType.stringForm)
            
        ]
        if(phoneNumber != nil){ userAttributes.append(AuthUserAttribute(.phoneNumber, value: phoneNumber ?? "")) }
        if(highestTableCapacity != nil){ userAttributes.append(AuthUserAttribute(.custom("highestTableCapacity"), value: String(highestTableCapacity ?? 1))) }
        if(description != nil){ userAttributes.append(AuthUserAttribute(.custom("description"), value: description ?? ""))}
        if(address != nil){ userAttributes.append(AuthUserAttribute(.address, value: address ?? ""))}
        
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: email, password: password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                    handler(SignUpResponseTypes.CONFIRM_ACCOUNT)
                } else {
                    print("SignUp Complete")
                    handler(SignUpResponseTypes.SUCCESS)
                    
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
                handler(SignUpResponseTypes.ERROR)
            }
        }
    }
    
    static func signOutLocally() {
        Amplify.Auth.signOut() { result in
            switch result {
            case .success:
                print("Successfully signed out")
                
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }
    
    static func signOutGlobally(handler:@escaping (Bool)->Void) {
        Amplify.Auth.signOut(options: .init(globalSignOut: true)) { result in
            switch result {
            case .success:
                print("Successfully signed out")
                handler(true)
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }
    
    static func fetchAttributes(handler: @escaping ([AuthUserAttribute]?)->Void) {
        Amplify.Auth.fetchUserAttributes() { result in
            switch result {
            case .success(let attributes):
                handler(attributes)
                print("User attributes - \(attributes)")
            case .failure(let error):
                handler(nil)
                print("Fetching user attributes failed with error \(error)")
            }
        }
    }
    
    static func updateAttribute(userAttribute: AuthUserAttribute, handler: @escaping ((Bool)->Void)) {
        Amplify.Auth.update(userAttribute: userAttribute) { result in
            do {
                let updateResult = try result.get()
                switch updateResult.nextStep {
                case .confirmAttributeWithCode(let deliveryDetails, let info):
                    print("Confirm the attribute with details send to - \(deliveryDetails) \(String(describing: info))")
                case .done:
                    handler(true)
                    print("Update completed")
                }
            } catch {
                handler(false)
                print("Update attribute failed with error \(error)")
            }
        }
    }
    
    static func changePassword(oldPassword: String, newPassword: String, handler: @escaping ((Bool)->Void)) {
        Amplify.Auth.update(oldPassword: oldPassword, to: newPassword) { result in
            switch result {
            case .success:
                print("Change password succeeded")
                handler(true)
            case .failure(let error):
                print("Change password failed with error \(error)")
                handler(false)
            }
        }
    }
    
    static func confirmSignUp(for username: String, with confirmationCode: String, handler: @escaping ((Bool)->Void))  {
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
            switch result {
            case .success:
                print("Confirm signUp succeeded")
                handler(true)
            case .failure(let error):
                print("An error occurred while confirming sign up \(error)")
                handler(false)
            }
        }
    }
}
