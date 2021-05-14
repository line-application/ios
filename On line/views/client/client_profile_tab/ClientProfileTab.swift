//
//  ClientProfileTab.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct ClientProfileTab: View {
    @EnvironmentObject var settings: SettingsState
    
    @Binding var currentView: Bool
    @State var name:String = ""
    @State var password:String = ""
    @State var phone: String = ""
    @State var passwordConfirmation: String = ""



    var body: some View {
        VStack{
            //NavigationBarView
            ZStack {
                Rectangle()
                    .size(CGSize(width: 1000.0, height: 80.0))
                    .foregroundColor(.white)
                    .ignoresSafeArea()
                Text("Perfil")
                    .padding(.top, -165)
                    .font(.system(size: 25, weight: .heavy, design: .default))
                    .foregroundColor(Color("primary"))
                Divider()
                    .padding(.top, -115)
            }
                VStack {
                    ScrollView {
                        Text("")
                        Text("")
                        Text("")
                    Image("IconePerfilCliente")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    TextView(input: $name , label: "Nome", isSecure: false)
                    TextView(input: $phone , label: "Telefone", isSecure: false)
                    TextView(input: $password , label: "Nova Senha", isSecure: true)
                    TextView(input: $passwordConfirmation , label: "Confirmar senha", isSecure: true)
                    ButtonView(text: "SALVAR") {
                        currentView = false
                    }
                }
                    .padding(.top, -323)
            }
            Spacer()
        }
    }
}

//struct ClientProfileTab_Previews: PreviewProvider {
//    static var previews: some View {
//        ClientProfileTab(currentView: Binding<Bool>(Binding<Bool?>()) ?? true)
//    }
//}
