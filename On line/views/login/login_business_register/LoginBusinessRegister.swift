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
    @State var businessEmail : String = ""
    @State var businessPassword : String = ""
    @State var businessName : String = ""
    @State var businessNumber : String = ""
    @State var businessAddress : String = ""
    @State var businessDescription : String = ""
    @State var peoplePerTable = 1
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func handleSingUp() {
        settings.isLoading = true
        Authentication.signUp(name: businessName, password: businessPassword, email: businessEmail, phoneNumber: businessNumber, userType: .BUSINESS, highestTableCapacity: peoplePerTable, description: businessDescription) {
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
        ScrollView {
            Divider()
                .padding(.top, 10.0)
            VStack {
                TextView(input: $businessEmail, label: "E-mail", isSecure: false)
                TextView(input: $businessPassword, label: "Senha", isSecure: true)
                TextView(input: $businessName, label: "Nome do estabelecimento", isSecure: false)
                TextView(input: $businessNumber, label: "Telefone", isSecure: false)
                TextView(input: $businessAddress, label: "Endereço", isSecure: false)
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
                        .frame(maxWidth: 320, maxHeight: .infinity)
                        .border(Color("primary"))
                    Text(businessDescription).opacity(0).padding(.all, 8)
                }
                .padding(.bottom)
                NavigationLink(
                    destination: BusinessView(),
                    label: {
                        ButtonView(text: "CADASTRAR", action: handleSingUp)
                            .padding(.leading, 15.0)
                    })
            }
            .padding()
            Spacer()
                .padding()
                .navigationTitle(Text("Cadastro"))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
        }
        .navigationBarColor(UIColor.white)
        .navigationBarItems(leading:
                                Button(action : {
                                    self.mode.wrappedValue.dismiss()
                                }){
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(Color("primary"))
                                }).alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("Erro"),
                                        message: Text("Houve um problema ao registrar sua conta, tente novamente.")
                                    )
                                }
    }
    
    
}

struct LoginBusinessRegister_Previews: PreviewProvider {
    static var previews: some View {
        LoginBusinessRegister(businessEmail: "business@business.com", businessPassword: "business", businessName: "FryFood", businessNumber: "5133764356", businessAddress: "Avenida João Wallig 857 - Bairro x - Porto Alegre/RS", businessDescription: "Esta é a descrição do meu estabelecimento!")
    }
}
