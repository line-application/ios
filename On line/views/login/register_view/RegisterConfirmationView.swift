//
//  RegisterConfirmationView.swift
//  On line
//
//  Created by Diego Henrique on 20/05/21.
//

import SwiftUI

struct RegisterConfirmationView: View {
    
    func handleAccountConfirmation() {
        settings.isLoading = true
        Authentication.confirmSignUp(for: email, with: code) { success in
            print("logged: \(success)")
            DispatchQueue.main.async {
                if(success) {
                    Authentication.signOutGlobally{ success in
                        DispatchQueue.main.async {
                            if(success) {
                                settings.isAuthenticated = false
                            } else {
                                settings.showAlert = true
                            }
                        }
                    }
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
    
    func handleCodeResend() {
        Authentication.resendSignUpCode(email: email) { success in
            DispatchQueue.main.async {
                if(success) {
                    activeAlert = .third
                    showAlert = true
                } else {
                    activeAlert = .fourth
                    showAlert = true
                }
                settings.isLoading = false
            }
        }
    }
    
    @State private var activeAlert: ActiveAlert = .first
    @EnvironmentObject var settings: SettingsState
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var isWrong : Bool = false
    @State var code : String = ""
    @State var showAlert : Bool = false
    @Binding var shouldDismiss: Bool
    var email : String = ""
    var body: some View {
            ZStack {
                LoaderView()
                VStack(alignment: .center) {
                    Divider()
                        .padding(.horizontal,-20)
                    Text("Um código de verificação de 6 dígitos foi enviado para:")
                        .font(.system(size: 20))
                        .foregroundColor(Color("primary"))
                        .frame(width: 340, height: 59)
                        .padding(.bottom, 1)
                        .padding(.top, 10)
                    
                    Text("\(email)")
                        .font(.system(size: 20))
                        .foregroundColor(Color("primary"))
                        .bold()
                        .frame(maxWidth: 330, minHeight: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("primary"), lineWidth: 2)
                        )
                    Text("Por favor, digite-o abaixo:")
                        .font(.system(size: 18))
                        .foregroundColor(Color("primary"))
                        .frame(width: 240, height: 89)
                        .padding(.leading, -120)
                        .padding(.bottom, 1)
                        .padding(.top, 10)
                    HStack {
                        TextField("123456", text: $code)
                            .keyboardType(.phonePad)
                    }
                    .underlineTextField(isWrong: isWrong, input: code)
                    .padding(.vertical, -50)
                    .padding(.leading, -5)
                    .padding()
                    Text((code.count < 6 || code.count > 6) && code != "" ? "O código possui 6 dígitos" : "")
                        .font(.system(size: 10))
                        .foregroundColor(.red)
                        .padding(.leading, -162)
                        .padding(.top, -35)
                    Button(action: {
                        if code.count == 6 {
                            handleAccountConfirmation()
                        }
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 22.0)
                                .frame(width: 129, height: 44, alignment: .center)
                                .foregroundColor(Color("primary"))
                            Text("ENVIAR")
                                .foregroundColor(Color.white)
                                .bold()
                        }
                    })
                    Text("Deseja reenviar o código?")
                        .padding()
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                        .onTapGesture {
                            handleCodeResend()
                        }
                    
                    Spacer()
                    
                }
                .navigationTitle(Text("Confirmação de Cadastro"))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
            }
        
        .padding()
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
                return Alert(title: Text("Erro"), message: Text("Houve um problema ao validar sua conta, por favor, verifique o código digitado."))
            case .third:
                return Alert(title: Text("Código reenviado!"), message: Text("O código de verificação foi reenviado para o e-mail \(email)."))
            case .fourth:
                return Alert(title: Text("Erro"), message: Text("Houve um problema ao reenviar o código, por favor, tente novamente."))
            default:
                return Alert(title: Text("Conta confirmada! 😃"), message: Text("Sua conta foi confirmada! Por favor, faça o login."),
                    dismissButton: .default((Text("OK")), action: {
                                                shouldDismiss = true
                                                self.mode.wrappedValue.dismiss()}))
            }
        }
    }
}

//struct RegisterConfirmationView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterConfirmationView()
//    }
//}
