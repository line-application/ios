//
//  ClientProfileTab.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct ClientProfileTab: View {
    @EnvironmentObject var settings: SettingsState
    
    func handleSignOut() {
        settings.isLoading = true
        Authentication.signOutGlobally{ success in
            DispatchQueue.main.async {
                if(success) {
                    settings.isAuthenticated = false
                } else {
                    settings.showAlert = true
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
            }.alert(isPresented: $settings.showAlert) {
                Alert(
                    title: Text("Erro"),
                    message: Text("Houve um problema ao deslogar, por favor, tente novamente")
                )
            }
        }
    }
}

struct ClientProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ClientProfileTab()
    }
}
