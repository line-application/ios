//
//  ClientProfileTabView.swift
//  On line
//
//  Created by Felipe Grosze Nipper de Oliveira on 14/05/21.
//

import SwiftUI

struct ClientProfileTabView: View {
    @State var cameBack = false
    @EnvironmentObject var settings: SettingsState
    @State var currentView: Bool = false
    @State var showDataFetchAlert = false
    @State var name:String = ""
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
    
    func handleDataFetch() {
        settings.isLoading = true
        Authentication.fetchAttributes() { attributes in
            DispatchQueue.main.async {
                if let unwrappedAttributes = attributes {
                    unwrappedAttributes.forEach { attribute in
                        switch attribute.key {
                        case .name:
                            name = attribute.value
                        case .phoneNumber:
                            if (attribute.value.count == 13) {
                                let newPhone = String(attribute.value.dropFirst(3))
                                let phoneFormatted = newPhone.applyPatternOnNumbers(pattern: "(##) ####-####", replacementCharacter: "#")
                                phone = phoneFormatted
                            }
                            else {
                                let newPhone = String(attribute.value.dropFirst(3))
                                let phoneFormatted = newPhone.applyPatternOnNumbers(pattern: "(##) #####-####", replacementCharacter: "#")
                                phone = phoneFormatted
                            }
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
                    Divider()
                        .padding(.top,10)
                    VStack {
                        ScrollView {
                            Group {
                                Text("")
                                Text("")
                                Text("")
                                Image("IconePerfilCliente")
                                    .resizable()
                                    .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                // Text(name)
                                Spacer()
                                VStack() {
                                    Text("Nome")
                                        .foregroundColor(Color("primary"))
                                        .frame(width: 225, height: 29, alignment: .leading)
                                        .padding(.trailing, 45)
                                        .padding(.bottom, -5)
                                        .padding(.top, -10)
                                    Text("\(name)")
                                        .foregroundColor(Color("formText"))
                                        .frame(width: 225, height: 29, alignment: .leading)
                                        .padding(.trailing, 45)
                                        .padding(.top, 5)
                                    Text("Telefone")
                                        .foregroundColor(Color("primary"))
                                        .frame(width: 225, height: 29, alignment: .leading)
                                        .padding(.trailing, 45)
                                        .padding(.bottom, -5)
                                        .padding(.top, 10)
                                    Text("\(phone)")
                                        .foregroundColor(Color("formText"))
                                        .frame(width: 225, height: 29, alignment: .leading)
                                        .padding(.trailing, 45)
                                        .padding(.top, 5)
                                }
                            }
                            Text("\n\n\n")
                            NavigationLink(
                                destination: ClientProfileTab(cameBack: $cameBack),
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
                    .onAppear() {
                        handleDataFetch()
                    }
                    Spacer()
                }
            }
            .navigationTitle("Perfil")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarColor(UIColor.white)
            .onChange(of: cameBack, perform: { value in
                cameBack = false
                handleDataFetch()
            })
        }
        
    }

}

struct ClientProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ClientProfileTabView()
    }
}
