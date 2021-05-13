//
//  ClientProfileTab.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct ClientProfileTab: View {
    @EnvironmentObject var settings: SettingsState
//    @State var isLoading: Bool = false
    func handleSignOut() {
        settings.isLoading = true
        Authentication.signOutGlobally{ success in
            DispatchQueue.main.async {
                if(success) {
                    settings.isAuthenticated = false
                    
                } else {
                    //throw warning
                }
                settings.isLoading = false
            }
        }
    }
    var body: some View {
        ZStack {
            LoaderView()
            VStack {
                Text("Client Profile Tab")
                Button(action: handleSignOut, label: {
                    Text("Sign Out").accentColor(.blue)
                })
            }
        }
    }
}

struct ClientProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ClientProfileTab()
    }
}
