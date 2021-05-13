//
//  LoginVIew.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct LoginView: View {
    @State var isLoading = false
    @Namespace var animation
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var settings: SettingsState

    
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
                                    .foregroundColor(settings.userType == UserType.CLIENT ? .white : Color("primary"))
                                    .padding(.vertical, 12)
                                    .padding(.leading, 40)
                                    .padding(.trailing, 40)
                                    .background(
                                        ZStack{
                                            if settings.userType == UserType.CLIENT{
                                                Color("primary")
                                                    .cornerRadius(30)
                                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                            }
                                        }
                                    )
                                    .foregroundColor(settings.userType == UserType.CLIENT ? .black : .white)
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                            settings.userType = UserType.CLIENT
                                        }
                                    }
                                
                                Text("Estabelecimento")
                                    .foregroundColor(settings.userType == UserType.BUSINESS ? .white : Color("primary"))
                                    .padding(.vertical, 12)
                                    .padding(.leading, 20)
                                    .padding(.trailing, 14)
                                    .background(
                                        ZStack{
                                            if settings.userType == UserType.BUSINESS{
                                                Color("primary")
                                                    .cornerRadius(35)
                                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                            }
                                        }
                                    )
                                    .foregroundColor(settings.userType == UserType.BUSINESS ? .black : .white)
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                            settings.userType = UserType.BUSINESS
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
                    Button("Sign in with Apple"){
                    }
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .frame(width: 280, height: 44)
                    .background(Color.black)
                    .cornerRadius(16)
                    .padding(5)
                    Button("Sign in with Facebook"){
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

