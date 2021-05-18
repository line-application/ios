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
                                let range = attribute.value.index(attribute.value.startIndex, offsetBy: 3)..<attribute.value.endIndex
                                var newPhone = attribute.value
                                newPhone.removeSubrange(range)
                                let phoneFormatted = newPhone.applyPatternOnNumbers(pattern: "(##) ####-####", replacementCharacter: "#")
                                phone = phoneFormatted
                            }
                            else {
                                let range = attribute.value.index(attribute.value.startIndex, offsetBy: 3)..<attribute.value.endIndex
                                var newPhone = attribute.value
                                newPhone.removeSubrange(range)
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
        //        if(currentView == true){
        //            ClientProfileTab(currentView: $currentView )
        //        }
        //        else {
        NavigationView {
            ZStack {
                //  LoaderView()
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
                    Spacer()
                }
            }
            .navigationTitle(Text("Perfil")
                                .font(.title)
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarColor(UIColor.white)
        }
        .onAppear() {
            handleDataFetch()
        }
    }
    //}
}

struct ClientProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ClientProfileTabView()
    }
}
