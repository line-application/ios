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
    @Binding var cameBack : Bool
    @State private var activeAlert: ActiveAlert = .first
    @State var isWrong = false
    @State var showAlert: Bool = false
    @State var showWarning : Bool = false
    @State var showOldPasswordWarning : Bool = false
    @State var oldPassword : String = ""
    @State var name:String = ""
    @State var password:String = ""
    @State var phone: String = ""
    @State var passwordConfirmation: String = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func handlePasswordChange(completion: @escaping ()->(Void)) {
        settings.isLoading = true
        Authentication.changePassword(oldPassword: oldPassword, newPassword: password) { success in
            DispatchQueue.main.async {
                if(success) {
                    showOldPasswordWarning = false
                } else {
                    showOldPasswordWarning = true
                }
                settings.isLoading = false
                completion()
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
                    self.activeAlert = .third
                    showAlert = true
                }
            }
        }
    }
    
    func handleAttributesUpdate() {
        settings.isLoading = true
        let dataTypes: [[AuthUserAttributeKey : String]] = [[.name : name], [.phoneNumber : "+55" + phone]]
        let dispatchGroup = DispatchGroup()
        var keysWithError: [AuthUserAttributeKey] = []
        
        for dictionary in dataTypes {
            print("🟢")
            dispatchGroup.enter()
            guard let key = dictionary.first?.key,
                  let value = dictionary.first?.value
            else {
                dispatchGroup.leave()
                continue
            }
            
            Authentication.updateAttribute(userAttribute: AuthUserAttribute(key, value: value)){ success in
                DispatchQueue.main.async {
                    if !success {
                        keysWithError.append(key)
                    }
                    print("🔵")
                    dispatchGroup.leave()
                }
            }
            
        }
        
        dispatchGroup.notify(queue: .main) {
            settings.isLoading = false
            if (keysWithError.isEmpty) {
                self.activeAlert = .first
                showAlert = true
            }
            else {
                self.activeAlert = .second
                showAlert = true
            }
            print("🔴")
        }
    }
    
    var body: some View {
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
                            }
                            else {
                                DispatchQueue.global(qos: .background).async {
                                    let dispatchSemaphore = DispatchSemaphore(value: 0)
                                    handlePasswordChange() {
                                        dispatchSemaphore.signal()
                                    }
                                    dispatchSemaphore.wait()
                                    DispatchQueue.main.async {
                                        if !showOldPasswordWarning {
                                            phone = phone.replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range: nil)
                                            phone = phone.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
                                            phone = phone.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
                                            phone = phone.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
                                            handleAttributesUpdate()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        switch activeAlert {
                        case .first:
                            return Alert(title: Text("Feito! 😃"), message: Text("Dados editados com sucesso!"),
                                         dismissButton: .default((Text("OK")), action: {
                                                                    cameBack = true
                                                                    self.mode.wrappedValue.dismiss()}))
                        case .second:
                            return Alert(title: Text("Erro"), message: Text("Houve um problema ao editar sua conta, por favor, tente novamente."))
                        case .third:
                            return Alert(
                                title: Text("Erro"),
                                message: Text("Houve um problema ao recuperar seus dados, por favor, tente novamente")
                            )
                        }
                    }
                    
                    
                    ButtonView3(text: "Deletar conta"){
                        
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Deletar conta"), message: Text("Você realemnte deseja deletar sua conta?"), primaryButton: .destructive(Text("Não")), secondaryButton: .cancel(Text("Não")))
                    }
                    
                    
                }
                .onAppear() {
                    handleDataFetch()
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
    }
}

//struct ClientProfileTab_Previews: PreviewProvider {
//    static var previews: some View {
//        ClientProfileTab(currentView: Binding<Bool>(Binding<Bool?>()) ?? true)
//    }
//}
