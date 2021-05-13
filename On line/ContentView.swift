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
    @StateObject var settings = SettingsState()
    var body: some View {
        ApplicationView().environmentObject(settings)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
