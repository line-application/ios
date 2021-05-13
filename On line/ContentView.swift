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
    @State var isAuthenticated:Bool = false
    var body: some View {
        ZStack {
            if isAuthenticated {
                ApplicationView()
            } else {
                LoginView()
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
