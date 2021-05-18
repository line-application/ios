//
//  BusinessView.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct BusinessView: View {
    
    @State var selectedTab:Tabs = .home
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor(named: "primary")
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
           
            BusinessDashboardTab()
                .tabItem {
                    Image(selectedTab == Tabs.home ? "Icone_Home_bold" : "RelogioBranco")
                    Text(" Zaitty")
                }
                .tag(Tabs.home)
            BusinessClientsInLineTab(people: 2, name: "João", time: 30)
                .tabItem {
                    Image(selectedTab == Tabs.list ? "Icone_Lista_bold" : "ListaBranca")
                    Text("Fila")
                }
                .tag(Tabs.list)
            BusinessProfileTabView()
                .tabItem {
                    Image(selectedTab == Tabs.profile ? "Icone_Perfil_bold" : "PerfilBranco")
                    Text("Perfil")
                }
                .tag(Tabs.profile)
        }
        .accentColor(Color.white)

    }
    
//    var body: some View {
//        TabView {
//
//            BusinessDashboardTab()
//                .tabItem {
//                    Label("Dashboard", systemImage: "list.dash")
//                }
//            BusinessClientsInLineTab()
//                .tabItem {
//                    Label("Clients", systemImage: "list.dash")
//                }
//            BusinessProfileTabView()
//                .tabItem {
//                    Label("Profile", systemImage: "list.dash")
//                }
//
//        }
//    }
}

struct BusinessView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessView()
    }
}
