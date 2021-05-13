//
//  LoginClientRegister.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct LoginClientRegister: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var name: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConfirmation: String = ""
    func handleSingUp() {
        Authentication.signUp(name: name,password: password, email: email, userType: .CLIENT)
    }
    var body: some View {
        
        
        ScrollView {
            
            VStack{
                TextView(input: $name , label: "Nome", isSecure: false)
                TextView(input: $phone , label: "Telefone", isSecure: false)
                TextView(input: $email , label: "E-mail", isSecure: false)
                TextView(input: $password , label: "Senha", isSecure: false)
                TextView(input: $passwordConfirmation , label: "Confirmar senha", isSecure: true)
                ButtonView(text: "CADASTRAR") {
                    self.mode.wrappedValue.dismiss()
                    handleSingUp()
                }
            }
            .padding()
            .navigationTitle(Text("Cadastro"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarColor(UIColor(named: "primary"))
        .navigationBarItems(leading:
                                Button(action : {
                                    self.mode.wrappedValue.dismiss()
                                }){
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(.white)
                                })
    }
}

struct LoginClientRegister_Previews: PreviewProvider {
    static var previews: some View {
        LoginClientRegister()
    }
}
