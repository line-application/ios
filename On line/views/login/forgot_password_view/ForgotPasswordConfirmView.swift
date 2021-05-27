//
//  ForgotPasswordConfirmView.swift
//  On line
//
//  Created by Diego Henrique on 27/05/21.
//

import SwiftUI

struct ForgotPasswordConfirmView: View {
    func handlePasswordResetConfirm() {
        settings.isLoading = true
        Authentication.confirmResetPassword(username: email, newPassword: password, confirmationCode: code) { success in
            print("result: \(success)")
            DispatchQueue.main.async {
                if(success) {
                    activeAlert = .first
                    showAlert = true
                } else {
                    activeAlert = .second
                    showAlert = true
                }
                settings.isLoading = false
            }
        }
    }
    
    @State private var activeAlert: ActiveAlert = .first
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var settings: SettingsState
    @State var isWrong: Bool = false
    @Binding var shouldDismiss: Bool
    var email: String
    @State var code: String = ""
    @State private var actionState: Int? = 0
    @State var showAlert: Bool = false
    @State var password: String = ""
    @State var passwordConfirm: String = ""
    
    var body: some View {
        ZStack{
            LoaderView()
            VStack {
                Divider()
                    .padding(.horizontal,-20)
                    .padding(.top, -10)
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 173, height: 51, alignment: .center)
                    .padding(.top, 35)
                    .padding(.bottom, 38)
                VStack (alignment: .leading) {
                    Text("Insira aqui o código enviado para o e-mail \(email)")
                        .foregroundColor(Color("primary"))
                        .frame(width: 274, height: 46)
                        .padding(.bottom, 5)
                        .padding(.top, -10)
                    HStack {
                        TextField("", text: $code)
                            .keyboardType(.phonePad)
                            .textFieldStyle(OvalTextFieldStyle())
                    }
                }
                .padding()
                Text((code.count < 6 || code.count > 6) && code != "" ? "O código possui 6 dígitos" : "")
                    .font(.system(size: 10))
                    .foregroundColor(.red)
                    .padding(.leading, -162)
                    .padding(.top, -22)
                TextView(isWrong: $isWrong, input: $password, label: "Nova senha", isSecure: true)
                Text(password.count < 6 && password != "" ? "Sua senha deve ter pelo menos 6 caracteres" : "")
                    .font(.system(size: 10))
                    .foregroundColor(.red)
                    .padding(.leading, -98)
                    .padding(.top, -15)
                    .padding(.bottom, 15)
                TextView(isWrong: $isWrong, input: $passwordConfirm, label: "Confirmar nova senha", isSecure: true)
                Text(password != passwordConfirm && passwordConfirm != "" ? "As senhas não conferem" : "")
                    .font(.system(size: 10))
                    .foregroundColor(.red)
                    .padding(.leading, -158)
                    .padding(.top, -15)
                    .padding(.bottom, 15)
                Group {
                    ButtonView(text: "OK") {
                        if code.count < 6 || password != passwordConfirm || password.count < 6 {
                            isWrong = true
                        }
                        else {
                            handlePasswordResetConfirm()
                        }
                    }
                    .padding(.bottom, 32)
                    Spacer()
                }
            }
            .padding()
            .navigationTitle(Text("Redefinição de senha"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarColor(UIColor.white)
        .navigationBarItems(leading:
                                Button(action : {
                                    self.mode.wrappedValue.dismiss()
                                }){
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(Color("primary"))
                                })
        .alert(isPresented: $showAlert) {
            switch activeAlert {
            case .second:
                return Alert(title: Text("Erro"), message: Text("Houve um problema ao redefinir sua senha, por favor, tente novamente."))
            default:
                return Alert(title: Text("Senha redefinida!"), message: Text("Sua senha foi redefinida! Por favor, faça o login."),
                             dismissButton: .default((Text("OK")), action: {
                                                        shouldDismiss = true
                                                        self.mode.wrappedValue.dismiss()}))
            }
        }
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(7)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("graySelector"), lineWidth: 1)
            )
            .cornerRadius(10)
    }
}

//struct ForgotPasswordConfirmView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForgotPasswordConfirmView()
//    }
//}
