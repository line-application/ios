//
//  ContentView.swift
//  On line
//
//  Created by Felipe Grosze Nipper de Oliveira on 04/05/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Text("This is a cool line app!")
            .padding()
            EnterLineButton()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
