//
//  LoginClientRegister.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct LoginClientRegister: View {
    @EnvironmentObject var settings: SettingsState
    @State var showAlert:Bool = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var name: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConfirmation: String = ""
    
    func handleSingUp() {
        settings.isLoading = true
        Authentication.signUp(name: name,password: password, email: email, phoneNumber: phone, userType: .CLIENT) {
            business in
            DispatchQueue.main.async {
                switch(business) {
                case .CONFIRM_ACCOUNT:
                    print("confirm your account")
                    self.mode.wrappedValue.dismiss()
                case .SUCCESS:
                    print("success")
                case .ERROR:
                    print("failed")
                    showAlert = true
                }
                DispatchQueue.main.async {
                    settings.isLoading = false
                }
            }
        }
    }
    
    var body: some View {
        ZStack{
            LoaderView()
            VStack{

                ScrollView {
                    
                    VStack{
                        TextView(input: $name , label: "Nome", isSecure: false)
                        TextView(input: $phone , label: "Telefone", isSecure: false)
                        TextView(input: $email , label: "E-mail", isSecure: false)
                        TextView(input: $password , label: "Senha", isSecure: false)
                        TextView(input: $passwordConfirmation , label: "Confirmar senha", isSecure: true)
                        ButtonView(text: "CADASTRAR") {
                            handleSingUp()
                        }
                    }
                    .padding()
                }
                .alert(isPresented: $showAlert) {
                                            Alert(
                                                title: Text("Erro"),
                                                message: Text("Houve um problema ao registrar sua conta, tente novamente.")
                                            )
                                        }
            }
            
        }
        
    }
}

struct LoginClientRegister_Previews: PreviewProvider {
    static var previews: some View {
        LoginClientRegister()
    }
}
