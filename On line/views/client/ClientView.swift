//
//  ClientView.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

enum Tabs {
    case home
    case list
    case profile
}

struct ClientView: View {
    @State var currentLine:BusinessModel? = nil
    @State var selectedTab:Tabs = .home
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor(named: "primary")
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
           
            ClientBusinessListTab(currentLine: $currentLine)
                .tabItem {
                    Image(selectedTab == Tabs.home ? "Icone_Home_bold" : "RelogioBranco")
                    Text(" Zaitty")
                }
                .tag(Tabs.home)
            ClientLineStatusTab(currentLine: $currentLine, lineplace: LinePlaceModel(enterLine: "", exitLine: "", called: "", invoked: false, success: false, peopleInLine: 3, businessEmail: "", clientEmail: ""))
                .tabItem {
                    Image(selectedTab == Tabs.list ? "Icone_Lista_bold" : "ListaBranca")
                    Text("Status da fila")
                }
                .tag(Tabs.list)
            ClientProfileTabView()
                .tabItem {
                    Image(selectedTab == Tabs.profile ? "Icone_Perfil_bold" : "PerfilBranco")
                    Text("Perfil")
                }
                .tag(Tabs.profile)
        }
        .accentColor(Color.white)

    }
}

struct ClientView_Previews: PreviewProvider {
    static var previews: some View {
        ClientView()
    }
}
