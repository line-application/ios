//
//  SettingsState.swift
//  On line
//
//  Created by Artur Luis on 12/05/21.
//

import Foundation

class SettingsState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var userType: UserType = UserType.LOADING
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    
    init() {
        Authentication.fetchAttributes() { attributes in
            DispatchQueue.main.async { [self] in
                if let unwrappedAttributes = attributes {
                    unwrappedAttributes.forEach { attribute in
                        switch attribute.key {
                        case .custom("userType"):
                            print(attribute.value)
                            userType = attribute.value == "business" ? .BUSINESS : .CLIENT
                            isAuthenticated = true
                        default:
                            return
                        }
                    }
                }
            }
        }
    }
}
