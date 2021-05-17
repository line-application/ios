//
//  LoginClientRegister.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct LoginClientRegister: View {
    @EnvironmentObject var settings: SettingsState
    @State var showAlert : Bool = false
    @State var showWarning : Bool = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var name: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConfirmation: String = ""
    
    func handleSingUp() {
        settings.isLoading = true
        Authentication.signUp(name: name,password: password, email: email, phoneNumber: "+55" + phone, userType: .CLIENT) {
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
                        Group {
                            TextView(isWrong: $showWarning, input: $name , label: "Nome", isSecure: false)
                            Text(name == "" && showWarning == true ? "Campo obrigatório" : "")
                                .font(.system(size: 10))
                                .foregroundColor(.red)
                                .padding(.leading, -158)
                                .padding(.top, -15)
                            TextView(isWrong: $showWarning, input: $phone , label: "Telefone", isSecure: false)
                            Text(phone == "" && showWarning == true ? "Campo obrigatório" : "")
                                .font(.system(size: 10))
                                .foregroundColor(.red)
                                .padding(.leading, -158)
                                .padding(.top, -15)
                            TextView(isWrong: $showWarning, input: $email , label: "E-mail", isSecure: false)
                            Text(email == "" && showWarning == true ? "Digite um e-mail válido" : "")
                                .font(.system(size: 10))
                                .foregroundColor(.red)
                                .padding(.leading, -158)
                                .padding(.top, -15)
                            TextView(isWrong: $showWarning, input: $password , label: "Senha", isSecure: true)
                            Text(password == "" && showWarning == true ? "Digite uma senha válida" : "")
                                .font(.system(size: 10))
                                .foregroundColor(.red)
                                .padding(.leading, -158)
                                .padding(.top, -15)
                            TextView(isWrong: $showWarning, input: $passwordConfirmation , label: "Confirmar senha", isSecure: true)
                            Text(password != passwordConfirmation && passwordConfirmation != "" ? "As senhas não conferem" : "")
                                .font(.system(size: 10))
                                .foregroundColor(.red)
                                .padding(.leading, -158)
                                .padding(.top, -15)
                        }
                        ButtonView(text: "CADASTRAR") {
                            if (password != passwordConfirmation || email == "" || name == "" || phone == "" || password == "") {
                                showWarning = true
                            }
                            else {
                                phone = phone.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
                                phone = phone.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
                                handleSingUp()
                            }
                        }
                        .padding()
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
