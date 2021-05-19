//
//  ProfileTabView.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct BusinessProfileTabView: View {
    @EnvironmentObject var settings: SettingsState
    @State var showDataFetchAlert = false
    @State var businessName : String = ""
    @State var businessNumber : String = ""
    @State var businessAddress : String = ""
    @State var businessDescription : String = ""
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
    
    func handleDataFetch() {
        settings.isLoading = true
        Authentication.fetchAttributes() { attributes in
            DispatchQueue.main.async {
                if let unwrappedAttributes = attributes {
                    
                    unwrappedAttributes.forEach { attribute in
                        switch attribute.key {
                        case .name:
                            businessName = attribute.value
                        case .phoneNumber:
                            if (attribute.value.count == 13) {
                                let phone = String(attribute.value.dropFirst(3))
                                let phoneFormatted = phone.applyPatternOnNumbers(pattern: "(##) ####-####", replacementCharacter: "#")
                                businessNumber = phoneFormatted
                            }
                            else {
                                let phone = String(attribute.value.dropFirst(3))
                                let phoneFormatted = phone.applyPatternOnNumbers(pattern: "(##) #####-####", replacementCharacter: "#")
                                businessNumber = phoneFormatted
                            }
                        case .address:
                            businessAddress = attribute.value
                        case .custom("description"):
                            businessDescription = attribute.value
                        case .custom("highestTableCapacity"):
                            peoplePerTable = Int(attribute.value)!
                        default:
                            return
                        }
                    }
                    settings.isLoading = false
                }
                
                else {
                    settings.isLoading = false
                    showDataFetchAlert = true
                }
            }
        }
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                LoaderView()
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
                                .padding(.bottom, -5)
                                .padding(.top, 10)
                            Text("\(businessDescription)")
                                .foregroundColor(Color("formText"))
                                .frame(maxWidth: 320, minHeight: 87, maxHeight: .infinity)
                                .padding(.horizontal, 5)
                                .padding(.bottom, 30)
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
                        .alert(isPresented: $showDataFetchAlert) {
                            Alert(
                                title: Text("Erro"),
                                message: Text("Houve um problema ao recuperar seus dados, por favor, tente novamente")
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
        .onAppear() {
            handleDataFetch()
        }
    }
    
    
}

struct BusinessProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessProfileTabView()
    }
}
