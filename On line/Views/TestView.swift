//
//  TestView.swift
//  On line
//
//  Created by Felipe Grosze Nipper de Oliveira on 06/05/21.
//

import SwiftUI

struct TestView: View {
    @State private var showingAlert = false
    var body: some View {
        VStack{
            Button("Show Alert") {
                        self.showingAlert = true
                    }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Você foi chamado!"), message: Text("vá até o restaurante"),primaryButton: Alert.Button.default(Text("Teste")) ,secondaryButton:.default(Text("OK")))
            }
    }
}
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
 
