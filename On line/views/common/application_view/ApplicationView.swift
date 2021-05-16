//
//  ApplicationView.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI
import Amplify

struct ApplicationView: View {
    @EnvironmentObject var settings: SettingsState
    var userType:UserType = UserType.CLIENT
    
    var body: some View {
        if settings.isAuthenticated {
            switch userType {
            case UserType.BUSINESS:
                BusinessView().allowsHitTesting(!settings.isLoading)
            case UserType.CLIENT:
                ClientView().allowsHitTesting(!settings.isLoading)
            }
        } else {
            LoginView().allowsHitTesting(!settings.isLoading)
        }
    }
}

struct ApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationView()
    }
}
