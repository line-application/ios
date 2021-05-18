//
//  ProfileTabView.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct BusinessProfileTabView: View {
    @EnvironmentObject var settings: SettingsState
    @State var businessName : String = "Outback Steakhouse"
    @State var businessNumber : String = "(51) 3332-7856"
    @State var businessAddress : String = "Avenida João Wallig 718"
    @State var businessDescription : String = "Descrição do Outback, um restaurante maravilhoso e ótimo para visitar. Venha!"
    @State var peoplePerTable = 1
    
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
        NavigationView {
            VStack{
                Divider() .padding(.top, 10.0)
                ScrollView {
                    VStack (alignment: .leading) {
                        Group {
                            Text("Nome do estabelecimento")
                                .foregroundColor(Color("primary"))
                                .frame(width: 225, height: 29, alignment: .leading)
                                .padding(.horizontal, 5)
                                .padding(.bottom, -5)
                                .padding(.top, -10)
                            Text("\(businessName)")
                                .foregroundColor(Color("formText"))
                                .frame(width: 225, height: 29, alignment: .leading)
                                .padding(.horizontal, 5)
                                .padding(.top, 5)
                            Text("Telefone")
                                .foregroundColor(Color("primary"))
                                .frame(width: 225, height: 29, alignment: .leading)
                                .padding(.horizontal, 5)
                                .padding(.bottom, -5)
                                .padding(.top, 10)
                            Text("\(businessNumber)")
                                .foregroundColor(Color("formText"))
                                .frame(width: 225, height: 29, alignment: .leading)
                                .padding(.horizontal, 5)
                                .padding(.top, 5)
                            Text("Endereço")
                                .foregroundColor(Color("primary"))
                                .frame(width: 225, height: 29, alignment: .leading)
                                .padding(.horizontal, 5)
                                .padding(.bottom, -5)
                                .padding(.top, 10)
                            Text("\(businessAddress)")
                                .foregroundColor(Color("formText"))
                                .frame(width: 225, height: 29, alignment: .leading)
                                .padding(.horizontal, 5)
                                .padding(.top, 5)
                            Text("Capacidade máx. de pessoas por mesa")
                                .foregroundColor(Color("primary"))
                                // .multilineTextAlignment(.center)
                                .frame(width: 300, height: 29)
                                .padding(.horizontal, 1)
                                .padding(.bottom, -5)
                                .padding(.top, 10)
                        }
                        Text(peoplePerTable != 1 ? "\(peoplePerTable) pessoas" : "\(peoplePerTable) pessoa")
                            .foregroundColor(Color(red: 106/255, green: 105/255, blue: 105/255))
                            .frame(width: 225, height: 29, alignment: .leading)
                            .padding(.horizontal, 5)
                            .padding(.top, 5)
                        Text("Descrição do estabelecimento")
                            .foregroundColor(Color("primary"))
                            .frame(width: 245, height: 29, alignment: .leading)
                            .padding(.horizontal, 5)
                            .padding(.bottom, 1)
                            .padding(.top, 10)
                            .padding(.leading, -5)
                        Text("\(businessDescription)")
                            .foregroundColor(Color("formText"))
                            //.padding(.all, 8)
                            .frame(maxWidth: 320, minHeight: 87, maxHeight: .infinity)
                            .padding(.bottom, 30)
                        // Text(businessDescription).opacity(0).padding(.all, 8)
                        NavigationLink(
                            destination: BusinessProfileEditor(),
                            label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 22.0)
                                        .frame(width: 129, height: 44, alignment: .center)
                                        .foregroundColor(Color("primary"))
                                    Text("EDITAR")
                                        .foregroundColor(Color.white)
                                        .bold()
                                }
                                    .padding(.leading, 95.0)
                                    .padding(.bottom, 20)
                            })
                        Button(action: handleSignOut, label: {
                            Text("SAIR")
                                .foregroundColor(.blue)
                                .padding(.leading, 140.0)
                            
                        })
                        
                    }
                    .alert(isPresented: $settings.showAlert) {
                                        Alert(
                                            title: Text("Erro"),
                                            message: Text("Houve um problema ao deslogar, por favor, tente novamente")
                                        )
                                    }
                    .padding(.top, 37)
                    Spacer()
                        .navigationTitle(Text("Perfil"))
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarColor(UIColor.white)
                }
            }
        }
        
    }
    
    
}

struct BusinessProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessProfileTabView()
    }
}
