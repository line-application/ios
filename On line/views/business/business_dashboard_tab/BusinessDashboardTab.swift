//
//  BusinessDashboardTab.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct BusinessDashboardTab: View {
    @State var currentTab = "Off"
    @Namespace var animation
    @State var peoplePerTable = 1
    var businessName: String = ""
    var peopleInLine: Int = 0
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 173, height: 51, alignment: .center)
            
            Divider()
            HStack() {
                Text("Olá, \(businessName)!")
                    .font(.system(size: 19))
                    .foregroundColor(Color("primary"))
                    .bold()
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .frame(width: 240, height: 75, alignment: .leading)
                
                Image("Clients Called")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 20, alignment: .center)
                    .padding(.leading, 33)
                
                
            }
            HStack {
                Text("Você quer abrir a fila?")
                    .font(.system(size: 17))
                    .foregroundColor(Color("primary"))
                
                ZStack {
                    ZStack{
                        HStack (spacing: -7){
                            Text("   Off   ")
                                .font(.system(size: 13))
                                .foregroundColor(Color("grayText"))
                                .padding(.vertical, 6)
                                .background(
                                    ZStack{
                                        if currentTab == "Off"{
                                            Color("graySelector")
                                                .cornerRadius(18)
                                                .matchedGeometryEffect(id: "TAB", in: animation)
                                        }
                                    }
                                )
                                .foregroundColor(currentTab == "Off" ? .black : .white)
                                .onTapGesture {
                                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                        currentTab = "Off"
                                    }
                                }
                            
                            Text("    On   ")
                                .font(.system(size: 13))
                                .foregroundColor(currentTab == "On" ? .white : .gray)
                                .padding(.vertical, 6)
                                .background(
                                    ZStack{
                                        if currentTab == "On"{
                                            Color("greenSelector")
                                                .cornerRadius(18)
                                                .matchedGeometryEffect(id: "TAB", in: animation)
                                        }
                                    }
                                )
                                .foregroundColor(currentTab == "On" ? .black : .white)
                                .onTapGesture {
                                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                        currentTab = "On"
                                    }
                                }
                        }
                        .background(Color.white)
                        .cornerRadius(20)
                    }
                    .padding(.vertical, 1)
                    .padding(.horizontal, 1)
                    .background(Color("primary"))
                    .cornerRadius(18)
                }
                .padding()
                .padding(.leading)
            }
            
            Text(peopleInLine == 0 ? "Nenhuma pessoa na fila" : peopleInLine == 1 ? "\(peopleInLine) pessoa na fila" : "\(peopleInLine) pessoas na fila")
                .font(.system(size: 19))
                .bold()
                .opacity(peopleInLine == 0 ? 0.5 : 1)
                .foregroundColor(Color("primary"))
                .frame(width: 307, height: 72)
                .background(Color("grayPeopleInLine"))
                .cornerRadius(10)
                .padding(35)
            
            Text("Capacidade de pessoas para a mesa seguinte")
                .font(.system(size: 16))
                .foregroundColor(Color("primary"))
                .multilineTextAlignment(.center)
                .frame(width: 350, height: 29, alignment: .center)
                .padding(.horizontal, 5)
                .padding(.bottom, -1)
                .padding(.top, 10)
                StepperView(peoplePerTable: $peoplePerTable)
                    .padding(20)
                    .padding(.top, -13.0)
            
            Button(action: {}, label: {
                Text("CHAMAR O PRÓXIMO")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 210, height: 44, alignment: .center)
                    .background(Color("primary"))
                    .opacity(peopleInLine == 0 ? 0.5 : 1)
                    .cornerRadius(22)
                
            })
            .disabled(peopleInLine == 0 ? true : false)
            .padding()
            
            Spacer()
        }
        .padding(.top)
    }
}

struct BusinessDashboardTab_Previews: PreviewProvider {
    static var previews: some View {
        BusinessDashboardTab(businessName: "Outback")
    }
}
