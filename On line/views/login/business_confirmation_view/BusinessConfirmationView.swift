//
//  BusinessConfirmationView.swift
//  On line
//
//  Created by Felipe Grosze Nipper de Oliveira on 27/05/21.
//

import SwiftUI

struct BusinessConfirmationView: View {
    @EnvironmentObject var settings: SettingsState
    @State var state:String = "R"
    @State var showAlertDelete: Bool = false
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

    var body: some View {
        switch state {
        case "R":
            VStack(){
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 173, height: 51, alignment: .center)
                    .padding(.top, 35)
                    .padding(.bottom, 38)
                ZStack{
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width*0.815, height: 124, alignment: .center)
                        .cornerRadius(10.0)
                        .foregroundColor(Color("grayPeopleInLine"))
                    VStack(alignment: .leading, spacing: 10){
                            Text("Recusada!")
                                .font(.system(size: 20))
                                .foregroundColor(Color("primary"))
                                .bold()
                                .multilineTextAlignment(.leading)
                                //.padding(.bottom,5) alignment: .leading
                        Text("Infelizmente sua conta não foi aprovada pelo time Zaitty.")
                            .font(.system(size: 18))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color("primary"))
                    }
                    .frame(width: UIScreen.main.bounds.width*0.805, height: 104, alignment: .center)
                    .padding(.bottom,10)
                }
                VStack {
                    Text("Para mais detlahes entre em contato")
                        .font(.system(size: 13))
                    HStack(spacing:0) {
                        Text("conosco pelo email")
                            .font(.system(size: 13))
                        Text(" zaittyapp@gmail.com")
                            .foregroundColor(Color("primary"))
                            .font(.system(size: 13))
                    }
                }
                .frame(width: UIScreen.main.bounds.width*0.815, height: 21, alignment: .center)
                .padding(.top,14)
                ButtonView(text: "OK", action: {
                    showAlertDelete.toggle()
                })
                .padding(.top,63)
                Spacer()
                    .alert(isPresented: $showAlertDelete) {
                        Alert(title: Text("Deletar conta"), message: Text("Você deseja deletar sua conta?"), primaryButton: .default(Text("Sim")){
                            handleSignOut()
                        }, secondaryButton: .default(Text("Não")){
                            handleSignOut()
                        })
                    }
            }
        default:
            VStack{
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 173, height: 51, alignment: .center)
                    .padding(.top, 35)
                    .padding(.bottom, 38)
                ZStack{
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width*0.815, height: 104, alignment: .center)
                        .cornerRadius(10.0)
                        .foregroundColor(Color("grayPeopleInLine"))
                    VStack(alignment: .leading, spacing: 10){
                            Text("Em análise!")
                                .font(.system(size: 20))
                                .foregroundColor(Color("primary"))
                                .bold()
                                .multilineTextAlignment(.leading)
                        Text("Sua conta ainda está em análise. \nAguarde a confirmação!")
                            .font(.system(size: 18))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color("primary"))
                    }
                    .frame(width: UIScreen.main.bounds.width*0.815, height: 104, alignment: .center)
                    ButtonView(text: "OK", action: {
                        handleSignOut()
                    })
                    .padding(.top,63)
                }
                Spacer()
            }
        }
    }
}

struct BusinessConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessConfirmationView()
    }
}
