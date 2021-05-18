//
//  BusinessDashboardClientsInLine.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct BusinessClientsInLineTab: View {
    
    @State var expand = false
    @State var people: Int
    @State var name: String
    @State var time: Int
    
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
            .padding(.horizontal, 5)
            .onTapGesture {
                
                self.expand.toggle()
            }
            if expand {
                VStack(alignment: .leading){
                    HStack {
                        Image("7464a45b0a8cb0c7-1")
                            .padding(.horizontal, 5)
                        
                        Text("\(people) pessoas")
                            .bold()
                            .foregroundColor(Color("primary"))
                            .padding(.horizontal, 5)
                        
                        Spacer()
                    }
                    .padding(.top,5)
                    .padding(.horizontal, 11)
                    
                    HStack{
                        
                        Image(systemName: "clock")
                            .foregroundColor(Color("primary"))
                            .padding(.horizontal, 5)
                        
                        Text("\(time) minutos na fila")
                            .bold()
                            .foregroundColor(Color("primary"))
                            .padding(.horizontal, 5)
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal, 13)
                    
                    HStack(alignment:.center){
                        
                        ButtonView3(text: "Tirar da fila", action: {
                            
                            print("Tira")
                        })
                        .padding(.horizontal, 30)
                        
                        ButtonView4(text: "CHAMAR", action: {
                            
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

struct BusinessClientsInLineTab_Previews: PreviewProvider {
    static var previews: some View {
        BusinessClientsInLineTab(people: 2, name: "João Gabriel", time: 30)
    }
}
