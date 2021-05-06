//
//  EnterLineButton.swift
//  On line
//
//  Created by Felipe Grosze Nipper de Oliveira on 06/05/21.
//

import SwiftUI

struct EnterLineButton: View {
    @State private var showingAlert = false
    @State private var showingAlert1 = false
    var body: some View {
        Button("Entrar na fila") {
                    self.showingAlert = true
                }
        .alert(isPresented: $showingAlert) {
            //Alert(title: Text("Você entrou na fila!"),dismissButton:.default(Text("OK")))
            Alert(title: Text("Você deseja entrar na fila?"), message: Text("vá até o restaurante"),primaryButton: .destructive(Text("Cancelar"))  {
                print("Test")
            } ,secondaryButton:.default(Text("Ok")){
                self.showingAlert1 = true
            }) //.default(Text("OK") .destructive(Text("Cancelar"))
        }
// Olhar isso
//        .alert(isPresented: $showingAlert1) {
//            Alert(title: Text("Você entrou na fila!"),dismissButton:.default(Text("OK")))
//        }
    }
}

struct EnterLineButton_Previews: PreviewProvider {
    static var previews: some View {
        EnterLineButton()
    }
}
