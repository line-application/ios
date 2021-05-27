//
//  ForgetPasswordView.swift
//  On line
//
//  Created by Diego Henrique on 26/05/21.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    func handleCodeSending() {
        // settings.isLoading = true
        Authentication.resetPassword(username: email) { success in
            print("result: \(success)")
            DispatchQueue.main.async {
                if(success) {
                    actionState = 1
                } else {
                    showAlert = true
                }
               // settings.isLoading = false
            }
        }
    }
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var settings: SettingsState
    @State var isWrong: Bool = false
    @Binding var shouldDismiss: Bool
    @State var email: String = ""
    @State private var actionState: Int? = 0
    @State var showAlert: Bool = false
    
    var body: some View {
        ZStack{
            LoaderView()
            VStack {
                Divider()
                    .padding(.horizontal,-20)
                    .padding(.top, -10)
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 173, height: 51, alignment: .center)
                    .padding(.top, 35)
                    .padding(.bottom, 38)
                
                TextView(isWrong: $isWrong, input: $email, label: "Digite seu e-mail", isSecure: false)
                    .padding(.bottom, 15)
                
                
                ButtonView(text: "ENVIAR") {
                    handleCodeSending()
                }
                    .padding(.bottom, 32)
                Spacer()
            }
            .padding()
            .navigationTitle(Text("Redefinição de senha"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            NavigationLink(destination: ForgotPasswordConfirmView(shouldDismiss: $shouldDismiss, email: email), tag: 1, selection: self.$actionState) {}
        }
        .navigationBarColor(UIColor.white)
        .navigationBarItems(leading:
                                Button(action : {
                                    self.mode.wrappedValue.dismiss()
                                }){
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(Color("primary"))
                                })
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Erro"),
                message: Text("Não foi possível localizar o e-mail informado. Verifique se há uma conta registrada com este e-mail.")
            )
        }
        .onChange(of: shouldDismiss, perform: { value in
            shouldDismiss = false
            self.mode.wrappedValue.dismiss()
        })
    }
}

//struct ForgotPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForgotPasswordView()
//    }
//}
