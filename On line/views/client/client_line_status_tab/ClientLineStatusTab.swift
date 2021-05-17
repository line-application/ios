//
//  ClientLineStatusTab.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct ClientLineStatusTab: View {
    @State var lineplace:LinePlaceModel
    var body: some View {
//        if(currentView == true){
//            ClientProfileTab(currentView: $currentView )
//        }
//        else {
            NavigationView {
                VStack{
                    Divider()
                        .padding(.top,25)
                    VStack {
                            ScrollView {
                                Text("")
                                Text("Você está na fila do restaurante Petiskeira!")
                                    .font(.title3)
                                    .foregroundColor(Color("primary"))
                                Text("")
                                HStack {
                                    Text("Mesa para ")
                                    Spacer()
                                    Image("Clients")
                                        .resizable()
                                        .frame(width: 26, height: 20, alignment: .center)
                                    if(lineplace.peopleInLine == 0){
                                        Text("Nenhuma pessoa na fila")
                                            .font(.system(size: 17))
                                            .foregroundColor(Color("primary"))
                                            .multilineTextAlignment(.leading)
                                            //.padding(.leading, 2.0)
                                            .frame(width: 200, alignment: .leading)
                                    }
                                    else if(lineplace.peopleInLine == 1){
                                        Text("\(Int(lineplace.peopleInLine ?? 0)) pessoa na fila")
                                            .font(.system(size: 17))
                                            .foregroundColor(Color("primary"))
                                            .multilineTextAlignment(.leading)
                                            //.padding(.leading, 2.0)
                                            .frame(width: 200, alignment: .leading)
                                    }
                                    else {
                                        Text("\(Int(lineplace.peopleInLine ?? 0)) pessoas na fila")
                                            .font(.system(size: 17))
                                            .foregroundColor(Color("primary"))
                                            .multilineTextAlignment(.leading)
                                            //.padding(.leading, 2.0)
                                            .frame(width: 200, alignment: .leading)
                                    }
                                }
                                .padding(.leading)
                                ZStack{
                                    Rectangle()
                                        .frame(width: 307, height: 67, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .cornerRadius(10.0)
                                        .foregroundColor(Color("grayPeopleInLine"))
                                    HStack {
                                        Image("clock")
                                            .resizable()
                                            .frame(width: 25.6, height: 27.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        Text(" 12:30 - 13:00")
                                            .font(.title3)
                                            .foregroundColor(Color("primary"))
                                            .bold()
                                    }
                                }
                            //Text(name)
                            Spacer()
                            Text("\n\n\n")
                            NavigationLink(
                                destination: ClientProfileTab(),
                                label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 22.0)
                                            .frame(width: 129, height: 44, alignment: .center)
                                            .foregroundColor(Color("primary"))
                                        Text("EDITAR")
                                            .foregroundColor(Color.white)
                                            .bold()
                                    }
                                })
                            Text("\n")
                        }
                            //.padding(.top, -323)
                    }
                    Spacer()
                }
                .navigationTitle(Text("Perfil")
                                    .font(.title)
                )
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarColor(UIColor.white)
            }
        }
    //}
}


struct ClientLineStatusTab_Previews: PreviewProvider {
    static var previews: some View {
        ClientLineStatusTab(lineplace: LinePlaceModel(enterLine: "", exitLine: "", called: "", invoked: false, success: false, peopleInLine: 3, businessEmail: "", clientEmail: ""))
    }
}
