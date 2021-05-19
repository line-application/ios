//
//  BusinessLine.swift
//  On line
//
//  Created by João Gabriel Biazus de Quevedo on 18/05/21.
//

import SwiftUI

struct BusinessLine: View {
    @State var expand = false
    @State var people: Int
    @State var name: String
    @State var clientEmail: String
    @State var time: Int
    
    func handleRemoveFromLine() {
        let linePlaceApi = LinePlaceApi()
        linePlaceApi.remove(type: .AsBusiness, email: clientEmail, handler: {_ in })
    }
    
    func handleCall() {
        let linePlaceApi = LinePlaceApi()
        linePlaceApi.confirm(clientEmail: clientEmail, handler: {_ in })
    }
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Image(expand ? "MenosAzul" : "MaisAzul")
                    .padding(.leading, 1)
                Text(expand ? "" : "\(people)")
                    .font(.system(size: 17))
                    .foregroundColor(Color("primary"))
                    .bold()
                    .padding(.leading, 20)
                Image(expand ? "" : "7464a45b0a8cb0c7-1")
                    .padding(.horizontal, 2)
                Text("\(name)")
                    .font(.system(size: 17))
                    .foregroundColor(Color("primary"))
                    .bold()
                    .padding(.leading, 1)
                Spacer()
            }
            .padding(.horizontal, 20)
            .onTapGesture {
    
                self.expand.toggle()
            }
            if expand {
                VStack(alignment: .leading){
                    HStack {
                        Image("7464a45b0a8cb0c7-1")
                            .padding(.leading, 25)
    
                        Text("\(people) pessoas")
                            .bold()
                            .foregroundColor(Color("primary"))
                            .padding(.horizontal, 10)
    
                        Spacer()
                    }
                    .padding(.top,5)
                    .padding(.horizontal, 15)
    
                    HStack{
    
                        Image(systemName: "clock")
                            .foregroundColor(Color("primary"))
                            .padding(.leading, 25)
    
                        Text("\(time) minutos na fila")
                            .bold()
                            .foregroundColor(Color("primary"))
                            .padding(.horizontal, 10)
    
                        Spacer()
    
                    }
                    .padding(.horizontal, 17)
    
                    HStack(alignment:.center){
    
                        ButtonView3(text: "Tirar da fila", action: {
                            handleRemoveFromLine()
                        })
                        .padding(.horizontal, 30)
    
                        ButtonView4(text: "CHAMAR", action: {
                            handleCall()
                            print("Entrar")
                        })
                    }
                }
                .padding(.horizontal, 0)
    
            }
            Divider()
        }
        .padding(10)
        .background(Color.white)
        .animation(.spring())
    }
    }
struct BusinessLine_Previews: PreviewProvider {
    static var previews: some View {
        BusinessLine(people: 2, name: "João Gabriel", clientEmail: "", time: 30)
    }
}

