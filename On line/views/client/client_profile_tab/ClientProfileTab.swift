//
//  ClientProfileTab.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI
import Amplify

struct ClientProfileTab: View {
    @EnvironmentObject var settings: SettingsState
    
    //@Binding var currentView: Bool
    @State var isWrong = false
    @State var showDataFetchAlert: Bool = false
    @State var showAlert: Bool = false
    @State var showWarning : Bool = false
    @State var showOldPasswordWarning : Bool = false
    @State var showDataEditSucessAlert : Bool = false
    @State var oldPassword : String = ""
    @State var name:String = ""
    @State var password:String = ""
    @State var phone: String = ""
    @State var passwordConfirmation: String = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func handlePasswordChange() {
        settings.isLoading = true
        Authentication.changePassword(oldPassword: oldPassword, newPassword: password) { success in
            DispatchQueue.main.async {
                if(success) {
                    showOldPasswordWarning = false
                } else {
                    showOldPasswordWarning = true
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
    
    func handleAttributesUpdate() {
        settings.isLoading = true
        Authentication.updateAttribute(userAttribute: AuthUserAttribute(.name, value: name)){ success in
            DispatchQueue.main.async {
                if(!success) {
                    settings.isLoading = false
                    showAlert = true
                }
            }
        }
        
        Authentication.updateAttribute(userAttribute: AuthUserAttribute(.phoneNumber, value: "+55" + phone)){ success in
            DispatchQueue.main.async {
                if(!success) {
                    settings.isLoading = false
                    showAlert = true
                }
            }
        }
        
        settings.isLoading = false
        showDataEditSucessAlert = true
    }
    
    var body: some View {
        VStack{
            //NavigationBarView
            //            ZStack {
            //                Rectangle()
            //                    .size(CGSize(width: 1000.0, height: 80.0))
            //                    .foregroundColor(.white)
            //                    .ignoresSafeArea()
            //                Text("Perfil")
            //                    .padding(.top, -165)
            //                    .font(.system(size: 25, weight: .heavy, design: .default))
            //                    .foregroundColor(Color("primary"))
            //                Divider()
            //                    .padding(.top, -115)
            //            }
            Divider()
                .padding(.top,25)
            VStack {
                ScrollView {
                    Group {
                        Text("")
                        Text("")
                        Text("")
                        Image("IconePerfilCliente")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        TextView(isWrong: $isWrong, input: $name , label: "Nome", isSecure: false)
                        Text(name == "" && showWarning == true ? "Campo obrigatório" : "")
                            .font(.system(size: 10))
                            .foregroundColor(.red)
                            .padding(.leading, -158)
                            .padding(.top, -15)
                        TextView(isWrong: $isWrong, input: $phone , label: "Telefone", isSecure: false)
                        Text(phone == "" && showWarning == true ? "Campo obrigatório" : "")
                            .font(.system(size: 10))
                            .foregroundColor(.red)
                            .padding(.leading, -158)
                            .padding(.top, -15)
                        TextView (isWrong: $showOldPasswordWarning, input: $oldPassword, label: "Senha antiga", isSecure: true)
                        Text(showOldPasswordWarning == true ? "Senha não correspondente" : "")
                            .font(.system(size: 10))
                            .foregroundColor(.red)
                            .padding(.leading, -158)
                            .padding(.top, -15)
                    }
                    TextView(isWrong: $isWrong, input: $password , label: "Nova Senha", isSecure: true)
                    Text(password.count < 6 && password != "" ? "Sua senha deve ter pelo menos 6 caracteres" : "")
                        .font(.system(size: 10))
                        .foregroundColor(.red)
                        .padding(.leading, -98)
                        .padding(.top, -15)
                    TextView(isWrong: $isWrong, input: $passwordConfirmation , label: "Confirmar senha", isSecure: true)
                    Text(password != passwordConfirmation && passwordConfirmation != "" ? "As senhas não conferem" : "")
                        .font(.system(size: 10))
                        .foregroundColor(.red)
                        .padding(.leading, -158)
                        .padding(.top, -15)
                    ButtonView(text: "SALVAR") {
                        if ((password != passwordConfirmation && password.count < 6) || name == "" || phone == "") {
                            showWarning = true
                        }
                        else {
                            if oldPassword == "" {
                                print("\(phone)")
                                phone = phone.replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range: nil)
                                phone = phone.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
                                phone = phone.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
                                phone = phone.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
                                handleAttributesUpdate()
                                if !showAlert {
                                    self.mode.wrappedValue.dismiss()
                                }
                            }
                            else {
                                handlePasswordChange()
                                if !showOldPasswordWarning {
                                    phone = phone.replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range: nil)
                                    phone = phone.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
                                    phone = phone.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
                                    phone = phone.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
                                    handleAttributesUpdate()
                                    if !showAlert {
                                        self.mode.wrappedValue.dismiss()
                                    }
                                }
                            }
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Erro"),
                        message: Text("Houve um problema ao editar sua conta, tente novamente.")
                    )
                }
                .alert(isPresented: $showDataFetchAlert) {
                    Alert(
                        title: Text("Erro"),
                        message: Text("Houve um problema ao recuperar seus dados, por favor, tente novamente")
                    )
                }
                .alert(isPresented: $showDataEditSucessAlert) {
                    Alert(
                        title: Text("Sucesso"),
                        message: Text("Dados editados com sucesso!")
                    )
                }
                .navigationTitle(Text("Perfil"))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarColor(UIColor.white)
                .navigationBarItems(leading:
                                        Button(action : {
                                            self.mode.wrappedValue.dismiss()
                                        }){
                                            Image(systemName: "chevron.backward")
                                                .foregroundColor(Color("primary"))
                                        })
            }
            .padding()
            Spacer()
        }
        .onAppear() {
            handleDataFetch()
        }
    }
}

//struct ClientProfileTab_Previews: PreviewProvider {
//    static var previews: some View {
//        ClientProfileTab(currentView: Binding<Bool>(Binding<Bool?>()) ?? true)
//    }
//}
