
//  Authentication.swift
//  On line
//
//  Created by Artur Luis on 05/05/21.
//

import Foundation
import Amplify
import AmplifyPlugins

struct Authentication {
    static func signIn(username: String, password: String) {
        
        Amplify.Auth.signIn(username: username, password: password) { result in
            switch result {
            case .success(let data):
                print("Sign in succeeded \(data)")
            case .failure(let error):
                print("Sign in failed \(error)")
            }
        }
        
    }
    
    static func signUp(password: String, email: String) {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: email, password: password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
            }
        }
    }
    
    func signOutLocally() {
        Amplify.Auth.signOut() { result in
            switch result {
            case .success:
                print("Successfully signed out")
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }
    
    static func fetchAttributes() {
        /**
         TODO
         - format incoming data.
         - return data.
         */
        Amplify.Auth.fetchUserAttributes() { result in
            switch result {
            case .success(let attributes):
                print("User attributes - \(attributes)")
            case .failure(let error):
                print("Fetching user attributes failed with error \(error)")
            }
        }
    }
}
