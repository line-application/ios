//
//  BusinessProfileEditor.swift
//  On line
//
//  Created by Diego Henrique on 17/05/21.
//

import SwiftUI

struct BusinessProfileEditor: View {
   // @EnvironmentObject var settings: SettingsState
    @State var showAlert:Bool = false
    @State var showWarning : Bool = false
    @State var businessEmail : String = ""
    @State var oldPassword : String = ""
    @State var businessPassword : String = ""
    @State var passwordConfirmation : String = ""
    @State var businessName : String = ""
    @State var businessNumber : String = ""
    @State var businessAddress : String = ""
    @State var businessDescription : String = ""
    @State var peoplePerTable = 1
    
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
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
                        .padding(.leading, -15)
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
                    TextView (isWrong: $showWarning, input: $oldPassword, label: "Senha antiga", isSecure: true)
                    Text(oldPassword == "" && showWarning == true ? "Senha não correspondente" : "")
                                    .font(.system(size: 10))
                                    .foregroundColor(.red)
                                    .padding(.leading, -158)
                                    .padding(.top, -15)
                    TextView (isWrong: $showWarning, input: $businessPassword, label: "Senha nova", isSecure: true)
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
                    NavigationLink(
                        destination: BusinessProfileTabView(),
                        label: {
                            ButtonView(text: "SALVAR") {
                                if (businessPassword != passwordConfirmation || businessEmail == "" || businessName == "" || businessNumber == "" || businessPassword == "" || businessAddress == "" || businessDescription == "") {
                                    showWarning = true
                                }
                                else {
                                    print("\(businessNumber)")
                                    businessNumber = businessNumber.replacingOccurrences(of: "(", with: "", options: NSString.CompareOptions.literal, range: nil)
                                    businessNumber = businessNumber.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
                                    businessNumber = businessNumber.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
                                    businessNumber = businessNumber.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
                                }
                            }
                            .padding(.top, 34)
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
                                            message: Text("Houve um problema ao editar sua conta, tente novamente.")
                                        )
                                    }
            .navigationTitle(Text("Perfil"))
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
                                })
    }
    
    
}

struct BusinessProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        BusinessProfileEditor()
    }
}
