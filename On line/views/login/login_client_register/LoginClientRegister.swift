//
//  LoginClientRegister.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct LoginClientRegister: View {
    @EnvironmentObject var settings: SettingsState
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var name: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConfirmation: String = ""
    
    func handleSingUp() {
        settings.isLoading = true
        Authentication.signUp(name: name,password: password, email: email, userType: .CLIENT) {
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
                    settings.showAlert = true
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
                                    }).alert(isPresented: $settings.showAlert) {
                                        Alert(
                                            title: Text("Erro"),
                                            message: Text("Houve um problema ao registrar sua conta, tente novamente.")
                                        )
                                    }
        }}
}

struct LoginClientRegister_Previews: PreviewProvider {
    static var previews: some View {
        LoginClientRegister()
    }
}
