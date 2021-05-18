//
//  ClientLineStatusTab.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct ClientLineStatusTab: View {
    @Binding var currentLine:BusinessModel?
    @State var lineplace:LinePlaceModel
    @State var showAlert:Bool = false
    //var bussinesModel: BusinessModel = BusinessModel(id: "1" ,email: "abc@gmail.com", name: "Teste", description: "Testeeeeeeeee", phone: "123456789", waitTime: 30.0, address: "Rua Dom Pedro, 888 - Porto Alegre", maxTableCapacity: 5, image: "Restaurante Azul")
    var body: some View {
        if(currentLine == nil){
            Text("não está em nenhuma fila")
        }
        else {
            NavigationView {
                VStack{
                    Divider()
                        .padding(.top,25)
                    VStack {
                            ScrollView {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(Color(imageColor(colorImage: currentLine!.image)))
                                        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15) ,radius: 5,x: 2, y: 4)
                                        .frame(width: UIScreen.main.bounds.width*0.9, height: 107, alignment: .leading)
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(Color(imageColor(colorImage: currentLine!.image)))
                                        .frame(width: UIScreen.main.bounds.width*0.9, height: 87, alignment: .leading)
                                        .offset(x: 0, y: 10)
                                    Image("\(currentLine!.image)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 107, height: 107, alignment: .center)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                    
                                }
                                Text("Você está na fila do restaurante \(currentLine!.name)!")
                                    .font(.title3)
                                    .foregroundColor(Color("primary"))
                                    .frame(width: UIScreen.main.bounds.width*0.8, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
                                HStack(spacing:120) {
                                    Text("Mesa para ")
                                    //Spacer()
                                    HStack {
                                        Image("Clients")
                                            .resizable()
                                            .frame(width: 26, height: 20, alignment: .center)
                                            //.padding(.leading, 2.0)
                                        if(lineplace.peopleInLine == 1){
                                            Text("\(Int(lineplace.peopleInLine ?? 0)) pessoa")
                                                //.font(.system(size: 17))
                                                .foregroundColor(Color("primary"))
                                                .multilineTextAlignment(.center)
                                                //.padding(.trailing, 2.0)
                                                //.frame(width: 200, alignment: .leading)
                                        }
                                        else {
                                            Text("\(Int(lineplace.peopleInLine ?? 0)) pessoas")
                                                //.font(.system(size: 17))
                                                .foregroundColor(Color("primary"))
                                                .multilineTextAlignment(.center)
                                                //.padding(.trailing, 2.0)
                                                //.frame(width: 200, alignment: .leading)
                                        }
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width*0.9, alignment: .center)
                                Text("\n")
                                HStack {
                                    Text("Previsão de retorno")
                                    Spacer()
                                }
                                .frame(width: UIScreen.main.bounds.width*0.82, alignment: .center)
                                if(lineplace.invoked==false) {
                                    ZStack{
                                        Rectangle()
                                            .frame(width: 328, height: 67, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .cornerRadius(10.0)
                                            .foregroundColor(Color("grayPeopleInLine"))
                                        HStack {
                                            Image("clock")
                                                .resizable()
                                                .frame(width: 25.6, height: 27.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            Text(" 12:30 - 13:00")
                                                .font(.title2)
                                                .foregroundColor(Color("primary"))
                                                .bold()
                                        }
                                    }
                                }
                                else {
                                    ZStack{
                                        Rectangle()
                                            .frame(width: 328, height: 67, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .cornerRadius(10.0)
                                            .foregroundColor(Color("greenSelector"))
                                        HStack {
                                            Text("VOCÊ FOI CHAMADO")
                                                .font(.title2)
                                                .foregroundColor(Color(.white))
                                                .bold()
                                        }
                                    }
                                }
                            //Text(name)
                                Button(action: {
                                    showAlert = true
                                }, label: {
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 22.0)
                                                .frame(width: 210, height: 44, alignment: .center)
                                                .foregroundColor(Color("primary"))
                                            Text("SAIR DA FILA")
                                                .foregroundColor(Color.white)
                                                .bold()
                                        }
                                        .padding(.top,65.0)
                                    
                                })
                            //Text("\n")
                        }
                            //.padding(.top, -323)
                    }
                    Spacer()
                }
                .navigationTitle(Text("Status da Fila")
                                    .font(.title)
                )
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarColor(UIColor.white)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Sair da Fila"), message: Text("Você realmente gostaria de sair da fila?"), primaryButton: .default(Text("Sim")){
                        lineplace.invoked = true
                    }, secondaryButton: .default(Text("Não")))
                                        }
            }
        }
    }
    func imageColor(colorImage:String) -> String {
        switch colorImage {
        case "Restaurante Laranja":
            return "orangeColor"
        case "Restaurante Azul":
            return "primary"
        case "Restaurante Rosa":
            return "pinkColor"
        case "Restaurante Verde":
            return "greenColor"
        default:
            return "orangeColor"
        }
    }
}


struct ClientLineStatusTab_Previews: PreviewProvider {
    static var previews: some View {
        ClientLineStatusTab(currentLine: Binding.constant(BusinessModel(id: "1" ,email: "abc@gmail.com", name: "Teste", description: "Testeeeeeeeee", phone: "123456789", waitTime: 30.0, address: "Rua Dom Pedro, 888 - Porto Alegre", maxTableCapacity: 5, image: "Restaurante Azul")), lineplace: LinePlaceModel(enterLine: "", exitLine: "", called: "", invoked: false, success: false, peopleInLine: 3, businessEmail: "", clientEmail: ""))
    }
}
