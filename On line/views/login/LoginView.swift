//
//  LoginVIew.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct LoginView: View {
    
    @State var currentTab = "Cliente"
    @Namespace var animation
    @State var email: String = ""
    @State var senha: String = ""
    
    var body: some View {
        //NavigationView{
            VStack{
                VStack {
                    ZStack {
                        ZStack{
                            HStack{
                                Text("Cliente")
                                    .foregroundColor(.black)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 25)
                                    .background(
                                        ZStack{
                                            if currentTab == "Cliente"{
                                                Color("primary")
                                                    .cornerRadius(18)
                                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                            }
                                        }
                                    )
                                    .foregroundColor(currentTab == "Cliente" ? .black : .white)
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                            currentTab = "Cliente"
                                        }
                                    }
                                Text("Estabelecimento")
                                    .foregroundColor(.black)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 25)
                                    .background(
                                        ZStack{
                                            if currentTab == "Estabelecimento"{
                                                Color("primary")
                                                    .cornerRadius(18)
                                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                            }
                                        }
                                    )
                                    .foregroundColor(currentTab == "Estabelecimento" ? .black : .white)
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                            currentTab = "Estabelecimento"
                                        }
                                    }
                            }
                            .padding(.vertical, 1)
                            .padding(.horizontal, 2)
                            .background(Color.white)
                            .cornerRadius(18)
                        }
                        .padding(.vertical, 3)
                        .padding(.horizontal, 3)
                        .background(Color("primary"))
                        .cornerRadius(18)
                    }

                    
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 173, height: 51, alignment: .center)
                        .padding(.top, 35)
                        .padding(.bottom, 38)

                    TextView(input: $email, label: "Email", isSecure: false)
                    TextView(input: $senha, label: "Senha", isSecure: true)
                        .padding(.bottom, 15)
                    
                    ButtonView(text: "ENTRAR", action: {})
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
                            .onTapGesture {
                            }
                    }
                    .padding(3)
                    Button("Sign in with Apple"){
                    }
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .frame(width: 280, height: 44)
                    .background(Color.black)
                    .cornerRadius(16)
                    .padding(5)
                    Button(" Sign in with Facebook"){
                    }
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .frame(width: 280, height: 44)
                    .background(Color("facebookColor"))
                    .cornerRadius(16)
                    .padding(5)
                    Button("Sign in with Google"){
                    }
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .frame(width: 280, height: 44)
                    .background(Color.black)
                    .cornerRadius(16)
                    .padding(5)
                }

            }
//                NavigationLink(
//                    destination: LoginClientRegister(),
//                    label: {
//                        Text("Login Client Register")
//                    })
//                NavigationLink(
//                    destination: LoginBusinessRegister(),
//                    label: {
//                        Text("Login Business Register")
//                    })
//

            }
            
        }
        
//   }

struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

