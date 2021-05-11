//
//  ClientView.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct ClientView: View {
    var body: some View {
        TabView {
           
            ClientBusinessListTab()
                .tabItem {
                    Label("Restaurants", systemImage: "list.dash")
                }
            ClientLineStatusTab()
                .tabItem {
                    Label("Status", systemImage: "list.dash")
                }
            ClientProfileTab()
                .tabItem {
                    Label("Profile", systemImage: "list.dash")
                }
        }
        
    }
}

struct ClientView_Previews: PreviewProvider {
    static var previews: some View {
        ClientView()
    }
}
