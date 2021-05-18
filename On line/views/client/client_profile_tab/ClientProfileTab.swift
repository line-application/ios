//
//  ClientProfileTab.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct ClientProfileTab: View {
    @EnvironmentObject var settings: SettingsState
    
    //@Binding var currentView: Bool
    @State var isWrong = false
    @State var name:String = ""
    @State var password:String = ""
    @State var phone: String = ""
    @State var passwordConfirmation: String = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
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
                        Text("")
                        Text("")
                        Text("")
                    Image("IconePerfilCliente")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        TextView(isWrong: $isWrong, input: $name , label: "Nome", isSecure: false)
                    TextView(isWrong: $isWrong, input: $phone , label: "Telefone", isSecure: false)
                        TextView(isWrong: $isWrong, input: $password , label: "Nova Senha", isSecure: true)
                        TextView(isWrong: $isWrong, input: $passwordConfirmation , label: "Confirmar senha", isSecure: true)
                    ButtonView(text: "SALVAR") {
                        //currentView = false
                        self.mode.wrappedValue.dismiss()
                    }
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
                    //.padding(.top, -323)
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
