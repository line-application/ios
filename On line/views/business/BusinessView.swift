//
//  BusinessView.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct BusinessView: View {
    var body: some View {
        TabView {
           
            BusinessDashboardTab()
                .tabItem {
                    Label("Dashboard", systemImage: "list.dash")
                }
            BusinessClientsInLineTab()
                .tabItem {
                    Label("Clients", systemImage: "list.dash")
                }
            BusinessProfileTabView()
                .tabItem {
                    Label("Profile", systemImage: "list.dash")
                }
            
        }
    }
}

struct BusinessView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessView()
    }
}
