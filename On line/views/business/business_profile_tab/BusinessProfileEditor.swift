//
//  BusinessProfileEditor.swift
//  On line
//
//  Created by Diego Henrique on 17/05/21.
//

import SwiftUI
import Amplify

struct BusinessProfileEditor: View {
    @EnvironmentObject var settings: SettingsState
    @State var showDataFetchAlert: Bool = false
    @State var showAlert: Bool = false
    @State var showWarning : Bool = false
    @State var showOldPasswordWarning : Bool = false
    @State var showDataEditSucessAlert : Bool = false
    @State var oldPassword : String = ""
    @State var businessPassword : String = ""
    @State var passwordConfirmation : String = ""
    @State var businessName : String = ""
    @State var businessNumber : String = ""
    @State var businessAddress : String = ""
    @State var businessDescription : String = ""
    @State var peoplePerTable = 1
    
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func handlePasswordChange() {
        settings.isLoading = true
        Authentication.changePassword(oldPassword: oldPassword, newPassword: businessPassword) { success in
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
    
    func handleAttributesUpdate() {
        settings.isLoading = true
        Authentication.updateAttribute(userAttribute: AuthUserAttribute(.name, value: businessName)){ success in
            DispatchQueue.main.async {
                if(!success) {
                    settings.isLoading = false
                    showAlert = true
                }
            }
        }
        Authentication.updateAttribute(userAttribute: AuthUserAttribute(.address, value: businessAddress)){ success in
            DispatchQueue.main.async {
                if(!success) {
                    settings.isLoading = false
                    showAlert = true
                }
            }
        }
        
        Authentication.updateAttribute(userAttribute: AuthUserAttribute(.phoneNumber, value: "+55" + businessNumber)){ success in
            DispatchQueue.main.async {
                if(!success) {
                    settings.isLoading = false
                    showAlert = true
                }
            }
        }
        
        Authentication.updateAttribute(userAttribute: AuthUserAttribute(.custom("description"), value: businessDescription)){ success in
            DispatchQueue.main.async {
                if(!success) {
                    settings.isLoading = false
                    showAlert = true
                }
            }
        }
        
        Authentication.updateAttribute(userAttribute: AuthUserAttribute(.custom("highestTableCapacity"), value: String(peoplePerTable))){ success in
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
        ZStack {
            LoaderView()
            VStack {
                Divider() .padding(.top, 10.0)
                ScrollView {
                    VStack {
                        Group {
                            TextView(isWrong: $showWarning, input: $businessName, label: "Nome do estabelecimento", isSecure: false)
                            Text(businessName == "" && showWarning == true ? "Campo obrigatório" : "")
                                .font(.system(size: 10))
                                .foregroundColor(.red)
                                .padding(.leading, -158)
                                .padding(.top, -15)
                            TextView(isWrong: $showWarning, input: $businessNumber, label: "Telefone", isSecure: false)
                            Text(businessNumber == "" && showWarning == true ? "Campo obrigatório" : "")
                                .font(.system(size: 10))
                                .foregroundColor(.red)
                                .padding(.leading, -158)
                                .padding(.top, -15)
                            TextView(isWrong: $showWarning, input: $businessAddress, label: "Endereço", isSecure: false)
                            Text(businessAddress == "" && showWarning == true ? "Campo obrigatório" : "")
                                .font(.system(size: 10))
                                .foregroundColor(.red)
                                .padding(.leading, -158)
                                .padding(.top, -15)
                            Text("Capacidade máx. de pessoas por mesa")
                                .foregroundColor(Color("primary"))
                                .multilineTextAlignment(.center)
                                .frame(width: 300, height: 29, alignment: .leading)
                                .padding(.horizontal, 5)
                                .padding(.bottom, -1)
                                .padding(.top, 10)
                                .padding(.leading, -20)
                            StepperView(peoplePerTable: $peoplePerTable)
                            Text("Descrição do estabelecimento")
                                .foregroundColor(Color("primary"))
                                .frame(width: 245, height: 29, alignment: .leading)
                                .padding(.horizontal, 5)
                                .padding(.bottom, 1)
                                .padding(.top, 10)
                                .padding(.leading, -75)
                        }
                        Group {
                            ZStack {
                                TextEditor(text: $businessDescription)
                                    .frame(maxWidth: 320, minHeight: 87, maxHeight: .infinity)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke((showWarning && businessDescription == "") ? Color.red : Color("primary"), lineWidth: 1)
                                    )
                                Text(businessDescription).opacity(0).padding(.all, 8)
                            }
                            .padding(.bottom)
                            Text(businessDescription == "" && showWarning == true ? "Campo obrigatório" : "")
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
                            TextView (isWrong: $showWarning, input: $businessPassword, label: "Senha nova", isSecure: true)
                            Text(businessPassword.count < 6 && businessPassword != "" ? "Sua senha deve ter pelo menos 6 caracteres" : "")
                                .font(.system(size: 10))
                                .foregroundColor(.red)
                                .padding(.leading, -98)
                                .padding(.top, -15)
                            TextView(isWrong: $showWarning, input: $passwordConfirmation, label: "Confirmar senha", isSecure: true)
                            Text(businessPassword != passwordConfirmation && passwordConfirmation != "" ? "As senhas não conferem" : "")
                                .font(.system(size: 10))
                                .foregroundColor(.red)
                                .padding(.leading, -158)
                                .padding(.top, -15)
                            Button(action: {
                                if ((businessPassword != passwordConfirmation && businessPassword.count < 6) || businessName == "" || businessNumber == "" || businessAddress == "" || businessDescription == "") {
                                        showWarning = true
                                    }
                                    else {
                                        if oldPassword == "" {
                                            print("\(businessNumber)")
                                            businessNumber = businessNumber.replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range: nil)
                                            businessNumber = businessNumber.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
                                            businessNumber = businessNumber.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
                                            businessNumber = businessNumber.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
                                            handleAttributesUpdate()
                                            self.mode.wrappedValue.dismiss()
                                        }
                                        else {
                                            handlePasswordChange()
                                            if !showOldPasswordWarning {
                                                businessNumber = businessNumber.replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range: nil)
                                                businessNumber = businessNumber.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
                                                businessNumber = businessNumber.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
                                                businessNumber = businessNumber.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
                                                handleAttributesUpdate()
                                                self.mode.wrappedValue.dismiss()
                                            }
                                        }
                                    }
                            }, label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 22.0)
                                        .frame(width: 129, height: 44, alignment: .center)
                                        .foregroundColor(Color("primary"))
                                    Text("SALVAR")
                                        .foregroundColor(Color.white)
                                        .bold()
                                }
                            })
                            .padding(.top, 35)
                        }
                    }
                    .padding()
                    Spacer()
                        .padding()
                    
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
            }
        }
        .navigationBarColor(UIColor.white)
        .navigationBarItems(leading:
                                Button(action : {
                                    self.mode.wrappedValue.dismiss()
                                }){
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(Color("primary"))
                                })
        .onAppear() {
            handleDataFetch()
        }
    }
    
}

struct BusinessProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        BusinessProfileEditor()
    }
}
