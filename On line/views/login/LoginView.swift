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
        NavigationView{
            VStack{
                VStack {
                    ZStack {
                        ZStack{
                            HStack{
                                Text("Cliente")
                                    .foregroundColor(currentTab == "Cliente" ? .white : Color("primary"))
                                    .padding(.vertical, 12)
                                    .padding(.leading, 40)
                                    .padding(.trailing, 40)
                                    .background(
                                        ZStack{
                                            if currentTab == "Cliente"{
                                                Color("primary")
                                                    .cornerRadius(30)
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
                                
                                Text("Estabelecimento ")
                                    .foregroundColor(currentTab == "Estabelecimento" ? .white : Color("primary"))
                                    .padding(.vertical, 12)
                                    .padding(.leading, 20)
                                    .padding(.trailing, 14)
                                    .background(
                                        ZStack{
                                            if currentTab == "Estabelecimento"{
                                                Color("primary")
                                                    .cornerRadius(35)
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
                    
                    TextView(input: $email, label: "E-mail", isSecure: false)
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
                        if currentTab == "Estabelecimento" {
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
                            Text("  Continuar com a Apple")
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
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        ZStack {
                            Text("        Continuar com o Facebook")
                                .font(.system(size: 15))
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 280, height: 44)
                                .background(Color("facebookColor"))
                                .cornerRadius(18)
                                .padding(5)
                            Image("Facebook Logo")
                                .resizable()
                                .frame(maxWidth: 25, maxHeight: 25)
                                .padding(.trailing, 205.0)
                                
                        }
                    })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        ZStack {
                            Text("   Continuar com o Google")
                                .font(.system(size: 15))
                                .bold()
                                .foregroundColor(.black)
                                .frame(width: 270, height: 32)
                                .background(Color.white)
                                .padding(5)
                                .overlay(
                                                RoundedRectangle(cornerRadius: 18)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                
                            Image("Google Logo")
                                .padding(.trailing, 205.0)
                        }
                    })
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

