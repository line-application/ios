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
                    UserTypeSegmentedControllView()
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 173, height: 51, alignment: .center)
                        .padding(.top, 35)
                        .padding(.bottom, 38)
                    
                    TextView(input: $email, label: "Email", isSecure: false)
                    TextView(input: $password, label: "Senha", isSecure: true)
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
                        if settings.userType == UserType.BUSINESS {
                            NavigationLink(destination: LoginBusinessRegister(),
                                           label: {
                                            Text("Cadastre-se")
                                                .font(.system(size: 14))
                                                .foregroundColor(.blue)})
                        }
                        
                        else {
                            NavigationLink(destination: LoginClientRegister(),
                                           label: {
                                            Text("Cadastre-se")
                                                .font(.system(size: 14))
                                                .foregroundColor(.blue)})
                        }
                    }
                    .padding(3)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        ZStack {
                            Text("Logar com conta Apple")
                                .font(.system(size: 15))
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 280, height: 44)
                                .background(Color.black)
                                .cornerRadius(18)
                                .padding(5)
                            Image("Left White Logo Large")
                                .padding(.trailing, 205.0)
                            //.frame(width: 10, height: 10)
                        }
                    })
//                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                        ZStack {
//                            Text("Continuar com o Facebook")
//                                .font(.system(size: 15))
//                                .bold()
//                                .foregroundColor(.white)
//                                .frame(width: 280, height: 44)
//                                .background(Color("facebookColor"))
//                                .cornerRadius(18)
//                                .padding(5)
//                            Image("Facebook Logo")
//                                .resizable()
//                                .frame(maxWidth: 25, maxHeight: 25)
//                                .padding(.trailing, 205.0)
//
//                        }
//                    })
//                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                        ZStack {
//                            Text("   Continuar com o Google")
//                                .font(.system(size: 15))
//                                .bold()
//                                .foregroundColor(.black)
//                                .frame(width: 270, height: 32)
//                                .background(Color.white)
//                                .padding(5)
//                                //.border(Color.black, width: 1)
//                                // .cornerRadius(18)
//
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 18)
//                                        .stroke(Color.black, lineWidth: 1)
//                                )
//
//                            Image("Google Logo")
//
//                                .padding(.trailing, 205.0)
//                            //.frame(width: 10, height: 10)
//                        }
//                        // .background(Color.black)
//                        //  .cornerRadius(50)
//                    })
                }
                
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

struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

