//
//  LoginBusinessRegister.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct LoginBusinessRegister: View {
    @EnvironmentObject var settings: SettingsState
    @State var showAlert:Bool = false
    @State var showWarning : Bool = false
    @State var businessEmail : String = ""
    @State var businessPassword : String = ""
    @State var passwordConfirmation : String = ""
    @State var businessName : String = ""
    @State var businessNumber : String = ""
    @State var businessAddress : String = ""
    @State var businessDescription : String = ""
    @State var peoplePerTable = 1
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func handleSingUp() {
        settings.isLoading = true
        Authentication.signUp(name: businessName, password: businessPassword, email: businessEmail, phoneNumber: "+55" + businessNumber, userType: .BUSINESS, highestTableCapacity: peoplePerTable, description: businessDescription) {
            business in
            DispatchQueue.main.async {
                switch(business) {
                case .CONFIRM_ACCOUNT:
                    print("confirm your account")
                    self.mode.wrappedValue.dismiss()
                case .SUCCESS:
                    print("success")
                case .ERROR:
                    print("failed")
                    showAlert = true
                }
                DispatchQueue.main.async {
                    settings.isLoading = false
                }
            }
        }
    }
    
    var body: some View {
        VStack{
            ScrollView {
                
                VStack {
                    Group {
                    TextView(isWrong: $showWarning, input: $businessEmail, label: "E-mail", isSecure: false)
                    Text(businessEmail == "" && showWarning == true ? "Digite um e-mail válido" : "")
                        .font(.system(size: 10))
                        .foregroundColor(.red)
                        .padding(.leading, -158)
                        .padding(.top, -15)
                    TextView(isWrong: $showWarning, input: $businessPassword, label: "Senha", isSecure: true)
                    Text(businessPassword == "" && showWarning == true ? "Digite uma senha válida" : "")
                            .font(.system(size: 10))
                            .foregroundColor(.red)
                            .padding(.leading, -158)
                            .padding(.top, -15)
                    TextView(isWrong: $showWarning, input: $passwordConfirmation, label: "Confirmar senha", isSecure: true)
                    Text(businessPassword != passwordConfirmation && passwordConfirmation != "" ? "As senhas não conferem" : "")
                        .font(.system(size: 10))
                        .foregroundColor(.red)
                        .padding(.leading, -158)
                        .padding(.top, -15)
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
                    }
                    Group {
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
                        .padding(.leading, -15)
                    StepperView(peoplePerTable: $peoplePerTable)
                    Text("Descrição do estabelecimento")
                        .foregroundColor(Color("primary"))
                        .frame(width: 245, height: 29, alignment: .leading)
                        .padding(.horizontal, 5)
                        .padding(.bottom, 1)
                        .padding(.top, 10)
                        .padding(.leading, -75)
                    ZStack {
                        TextEditor(text: $businessDescription)
                            .frame(maxWidth: 320, minHeight: 87, maxHeight: .infinity)
                            .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(showWarning ? Color.red : Color("primary"), lineWidth: 1)
                                    )
                        Text(businessDescription).opacity(0).padding(.all, 8)
                    }
                    .padding(.bottom)
                    Text(businessDescription == "" && showWarning == true ? "Campo obrigatório" : "")
                        .font(.system(size: 10))
                        .foregroundColor(.red)
                        .padding(.leading, -158)
                        .padding(.top, -15)
                    NavigationLink(
                        destination: BusinessView(),
                        label: {
                            ButtonView(text: "CADASTRAR") {
                                if (businessPassword != passwordConfirmation || businessEmail == "" || businessName == "" || businessNumber == "" || businessPassword == "" || businessAddress == "" || businessDescription == "") {
                                    showWarning = true
                                }
                                else {
                                    print("\(businessNumber)")
                                    businessNumber = businessNumber.replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range: nil)
                                    businessNumber = businessNumber.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
                                    businessNumber = businessNumber.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
                                    businessNumber = businessNumber.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
                                    handleSingUp()
                                }
                            }
                        })
                    }
                }
                .padding()
                Spacer()
                    .padding()
                
            }
            .alert(isPresented: $showAlert) {
                                        Alert(
                                            title: Text("Erro"),
                                            message: Text("Houve um problema ao registrar sua conta, tente novamente.")
                                        )
                                    }
        }}
    
    
}

struct LoginBusinessRegister_Previews: PreviewProvider {
    static var previews: some View {
        LoginBusinessRegister(businessEmail: "business@business.com", businessPassword: "business", passwordConfirmation: "d", businessName: "FryFood", businessNumber: "5133764356", businessAddress: "Avenida João Wallig 857 - Bairro x - Porto Alegre/RS", businessDescription: "Esta é a descrição do meu estabelecimento!")
    }
}
