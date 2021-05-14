//
//  ClientProfileTabView.swift
//  On line
//
//  Created by Felipe Grosze Nipper de Oliveira on 14/05/21.
//

import SwiftUI

struct ClientProfileTabView: View {
    //@Binding var client:ClientModel
    @State var currentView: Bool = false
    @State var name:String = "Teste"
    @State var password:String = ""
    @State var phone: String = ""
    @State var passwordConfirmation: String = ""
    var body: some View {
        if(currentView == true){
            ClientProfileTab(currentView: $currentView )
        }
        else {
            VStack{
                //NavigationBarView
                ZStack {
                    Rectangle()
                        .size(CGSize(width: 1000.0, height: 80.0))
                        .foregroundColor(.white)
                        .ignoresSafeArea()
                    Text("Perfil")
                        .padding(.top, -165)
                        .font(.system(size: 25, weight: .heavy, design: .default))
                        .foregroundColor(Color("primary"))
                    Divider()
                        .padding(.top, -115)
                }

                    VStack {
                        ScrollView {
                            Text("")
                            Text("")
                            Text("")
                        Image("IconePerfilCliente")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Text(name)
                        Spacer()
                        Text("\n\n\n")
                        ButtonView(text: "EDITAR") {
                            currentView = true
                        }
                        Text("\n")
                        Button(action: {
                                
                        }, label: {
                            Text("SAIR")
                                .foregroundColor(.blue)
                        })
                    }
                        .padding(.top, -323)
                }
                Spacer()
            }
        }
    }
}

struct ClientProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ClientProfileTabView()
    }
}
