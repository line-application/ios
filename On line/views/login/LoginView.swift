//
//  LoginVIew.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct LoginView: View {
    @Namespace var animation
    @State var email: String = ""
    @State var password: String = ""
    @State var isWrong = false
    @State var showRegisterAlert = false
    @State private var actionState: Int? = 0
    @EnvironmentObject var settings: SettingsState
    
    
    
    func handleSignIn() {
        settings.isLoading = true
        Authentication.signIn(username: email, password: password,handler: {success in print("logged: \(success)")
            DispatchQueue.main.async {
                if(success) {
                    settings.isAuthenticated = true
                } else {
                    settings.showAlert = true
                }
                settings.isLoading = false
            }
        })
        
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                LoaderView()
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 173, height: 51, alignment: .center)
                        .padding(.top, 35)
                        .padding(.bottom, 38)
                    
                    TextView(isWrong: $isWrong, input: $email, label: "E-mail", isSecure: false)
                    TextView(isWrong: $isWrong, input: $password, label: "Senha", isSecure: true)
                        .padding(.bottom, 15)
                    
                    
                    ButtonView(text: "ENTRAR", action: handleSignIn)
                        .padding(.bottom, 22)
                    
                    Text("Esqueci a senha")
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                        .padding(2)
                        .onTapGesture {
                        }
                    HStack{
                        Text("Ainda não tem cadastro?")
                            .font(.system(size: 14))
                        
                        Text("Cadastre-se")
                            .font(.system(size: 14))
                            .foregroundColor(.blue)
                            .actionSheet(isPresented: $showRegisterAlert) {
                                ActionSheet(
                                    title: Text("Quem você é?"),
                                    message: Text("Precisamos saber se você é um cliente ou um estabelecimento para efetuar o cadastro."),
                                    buttons: [
                                        .default(Text("Cliente"), action: {
                                            actionState = 1
                                            settings.userType = UserType.CLIENT
                                        }),
                                        .default(Text("Estabelecimento"), action: {
                                            actionState = 1
                                            settings.userType = UserType.BUSINESS
                                        }),
                                        .cancel(Text("Cancelar"))
                                    ]
                                    
                                )
                            }
                            .onTapGesture {
                                showRegisterAlert.toggle()
                            }
                        NavigationLink(destination: RegisterView(), tag: 1, selection: self.$actionState) {}
                        
                    }
                    
                    .padding(3)
                    //                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    //                        ZStack {
                    //                            Text("Continuar com a Apple")
                    //                                .font(.system(size: 15))
                    //                                .bold()
                    //                                .foregroundColor(.white)
                    //                                .frame(width: 280, height: 44)
                    //                                .background(Color.black)
                    //                                .cornerRadius(18)
                    //                                .padding(5)
                    //                            Image("Left White Logo Large")
                    //                                .padding(.trailing, 205.0)
                    //                            //.frame(width: 10, height: 10)
                    //                        }
                    //                    })
                    // Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    //     ZStack {
                    //         Text("        Continuar com o Facebook")
                    //             .font(.system(size: 15))
                    //             .bold()
                    //             .foregroundColor(.white)
                    //             .frame(width: 280, height: 44)
                    //             .background(Color("facebookColor"))
                    //             .cornerRadius(18)
                    //             .padding(5)
                    //         Image("Facebook Logo")
                    //             .resizable()
                    //             .frame(maxWidth: 25, maxHeight: 25)
                    //             .padding(.trailing, 205.0)
                    
                    //     }
                    // })
                    // Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    //     ZStack {
                    //         Text("   Continuar com o Google")
                    //             .font(.system(size: 15))
                    //             .bold()
                    //             .foregroundColor(.black)
                    //             .frame(width: 270, height: 32)
                    //             .background(Color.white)
                    //             .padding(5)
                    //             .overlay(
                    //                             RoundedRectangle(cornerRadius: 18)
                    //                             .stroke(Color.black, lineWidth: 1)
                    //                     )
                    
                    //         Image("Google Logo")
                    //             .padding(.trailing, 205.0)
                    //     }
                    // })
                    Spacer()
                }
                .padding()
                
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }.alert(isPresented: $settings.showAlert) {
            Alert(
                title: Text("Erro"),
                message: Text("Usuário ou senha inválidos.")
            )
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

