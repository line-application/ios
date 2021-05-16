//
//  ClientProfileTabView.swift
//  On line
//
//  Created by Felipe Grosze Nipper de Oliveira on 14/05/21.
//

import SwiftUI

struct ClientProfileTabView: View {
    //@Binding var client:ClientModel
    @EnvironmentObject var settings: SettingsState
    @State var currentView: Bool = false
    @State var name:String = "Teste"
    @State var password:String = ""
    @State var phone: String = ""
    @State var passwordConfirmation: String = ""
    
    func handleSignOut() {
        settings.isLoading = true
        Authentication.signOutGlobally{ success in
            DispatchQueue.main.async {
                if(success) {
                    settings.isAuthenticated = false
                } else {
                    settings.showAlert = true
                }
                settings.isLoading = false
            }
        }
    }
    
    var body: some View {
//        if(currentView == true){
//            ClientProfileTab(currentView: $currentView )
//        }
//        else {
            NavigationView {
                VStack{
                    Divider()
                        .padding(.top,25)
                    //NavigationBarView
    //                ZStack {
    //                    Rectangle()
    //                        .size(CGSize(width: 1000.0, height: 80.0))
    //                        .foregroundColor(.white)
    //                        .ignoresSafeArea()
    //                    Text("Perfil")
    //                        .padding(.top, -165)
    //                        .font(.system(size: 25, weight: .heavy, design: .default))
    //                        .foregroundColor(Color("primary"))
    //                    Divider()
    //                        .padding(.top, -115)
    //                }

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
                            NavigationLink(
                                destination: ClientProfileTab(),
                                label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 22.0)
                                            .frame(width: 129, height: 44, alignment: .center)
                                            .foregroundColor(Color("primary"))
                                        Text("EDITAR")
                                            .foregroundColor(Color.white)
                                            .bold()
                                    }
                                })
                            Text("\n")
                            Button(action: handleSignOut, label: {
                                Text("SAIR")
                                    .foregroundColor(.blue)
                            })
                        }
                            //.padding(.top, -323)
                    }.alert(isPresented: $settings.showAlert) {
                        Alert(
                            title: Text("Erro"),
                            message: Text("Houve um problema ao deslogar, por favor, tente novamente")
                        )
                    }
                    Spacer()
                }
                .navigationTitle(Text("Perfil")
                                    .font(.title)
                )
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarColor(UIColor.white)
            }
        }
    //}
}

struct ClientProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ClientProfileTabView()
    }
}
