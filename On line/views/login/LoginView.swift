//
//  LoginVIew.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct LoginView: View {
    @State var isLoading = false
    @State var currentTab:UserType = UserType.CLIENT
    @Namespace var animation
    @State var email: String = ""
    @State var password: String = ""
    
    func handleSignIn() {
        Authentication.signIn(username: email, password: password,handler: {success in print("logged: \(success)")})
    }
    
    var body: some View {
        NavigationView{
            VStack{
                LoaderView(isLoading: $isLoading)
                VStack {
                    ZStack {
                        ZStack{
                            HStack{
                                
                                Text("Cliente")
                                    .foregroundColor(currentTab == UserType.CLIENT ? .white : Color("primary"))
                                    .padding(.vertical, 12)
                                    .padding(.leading, 40)
                                    .padding(.trailing, 40)
                                    .background(
                                        ZStack{
                                            if currentTab == UserType.CLIENT{
                                                Color("primary")
                                                    .cornerRadius(30)
                                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                            }
                                        }
                                    )
                                    .foregroundColor(currentTab == UserType.CLIENT ? .black : .white)
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                            currentTab = UserType.CLIENT
                                        }
                                    }
                                
                                Text("Estabelecimento")
                                    .foregroundColor(currentTab == UserType.BUSINESS ? .white : Color("primary"))
                                    .padding(.vertical, 12)
                                    .padding(.leading, 20)
                                    .padding(.trailing, 14)
                                    .background(
                                        ZStack{
                                            if currentTab == UserType.BUSINESS{
                                                Color("primary")
                                                    .cornerRadius(35)
                                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                            }
                                        }
                                    )
                                    .foregroundColor(currentTab == UserType.BUSINESS ? .black : .white)
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                            currentTab = UserType.BUSINESS
                                        }
                                    }
                            }
                            .background(Color.white)
                            .cornerRadius(30)
                        }
                        .padding(.vertical, 3)
                        .padding(.horizontal, 3)
                        .background(Color("primary"))
                        .cornerRadius(30)
                    }

                    
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 173, height: 51, alignment: .center)
                        .padding(.top, 35)
                        .padding(.bottom, 38)

                    TextView(input: $email, label: "Email", isSecure: false)
                    TextView(input: $password, label: "Senha", isSecure: true)
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
                        if currentTab == UserType.BUSINESS {
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
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            }
        
        }
        
   }

struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

