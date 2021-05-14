//
//  ContentView.swift
//  On line
//
//  Created by Felipe Grosze Nipper de Oliveira on 04/05/21.
//

import SwiftUI
import UIKit
import Amplify
import AmplifyPlugins

struct ContentView: View {
<<<<<<< HEAD
    
    @StateObject var settings = SettingsState()
=======
    var isAuthenticated:Bool = true
>>>>>>> 9f9e328e33e2d467670d1d77e1b47441ae5656e9
    var body: some View {
        ApplicationView().environmentObject(settings).onAppear(perform: {
            if(Amplify.Auth.getCurrentUser() != nil) {
                settings.isAuthenticated = true
              
            }
            
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
