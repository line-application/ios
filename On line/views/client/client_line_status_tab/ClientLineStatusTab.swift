//
//  ClientLineStatusTab.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct ClientLineStatusTab: View {
    @EnvironmentObject var pushNotificationData: PushNotificationDataState
    @Binding var currentLine:BusinessModel?
    @Binding var lineplace:LinePlaceModel?
    @Binding var time2:TimeEstimativeModel?
    @State var clientName:String = ""
    @State var clientEmail:String = ""
    @State var showAlert:Bool = false
    @State var hour = Calendar.current.component(.hour, from: Date())
    @State var minutes = Calendar.current.component(.minute, from: Date())
    
    func time(timeString:IsoString) -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        let updatedAtStr = timeString
        let updatedAt = dateFormatter.date(from: updatedAtStr) // "Jun 5, 2016, 4:56 PM"
        return  updatedAt!
    }
    
    func findLinePlace(){
        let linePlaceApi = LinePlaceApi()
        linePlaceApi.find(handler: {findLinePlace in
            currentLine =  findLinePlace?.business
            lineplace = findLinePlace?.linePlace
        })
    }
    
    func handleDataFetch() {
        //settings.isLoading = true
        Authentication.fetchAttributes() { attributes in
            DispatchQueue.main.async {
                if let unwrappedAttributes = attributes {
                    unwrappedAttributes.forEach { attribute in
                        switch attribute.key {
                        case .name:
                            clientName = attribute.value
                        case .email:
                            clientEmail = attribute.value
                        default:
                            return
                        }
                    }
                }
                
                else {
                    //showDataFetchAlert = true
                }
            }
        }
        findLinePlace()
    }
    
    func handleRemoveFromLine() {
        handleDataFetch()
        let linePlaceApi = LinePlaceApi()
        linePlaceApi.remove(type: .AsClient, email: clientEmail, handler: {_ in })
    }
    
    var body: some View {
        if(currentLine == nil){
            NavigationView {
                VStack {
                    Divider()
                        //.padding(.top,31)
                    VStack {
                        ZStack{
                            Rectangle()
                                .frame(width: 328, height: 141, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .cornerRadius(10.0)
                                .foregroundColor(Color("grayPeopleInLine"))
                            VStack {
                                Text("Você não está em nenhuma na fila!")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color("primary"))
                                    .bold()
                                Text("Para entrar em uma fila escolha\n um restaurente.")
                                    .frame(width: 308, height: 50
                                           , alignment: .center)
                                    .font(.system(size: 15))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color("primary"))
                            }
                            .frame(width: 368, height: 141,alignment: .center)
                        }
                        .padding(.top)
                        Spacer()
                            .navigationTitle(Text("Status da Fila"))
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarBackButtonHidden(true)
                            .navigationBarColor(UIColor.white)
                    }
                }
            }
            .onAppear(){
                handleDataFetch()
            }
        }
        else {
            NavigationView {
                VStack{
                    Divider()
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
                                    if(lineplace?.peopleInLine == 1){
                                        Text("\(Int(lineplace?.peopleInLine ?? 0)) pessoa")
                                            //.font(.system(size: 17))
                                            .foregroundColor(Color("primary"))
                                            .multilineTextAlignment(.center)
                                        //.padding(.trailing, 2.0)
                                        //.frame(width: 200, alignment: .leading)
                                    }
                                    else {
                                        Text("\(Int(lineplace?.peopleInLine ?? 0)) pessoas")
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
                                if(lineplace?.invoked==nil) {
                                    ZStack{
                                        Rectangle()
                                            .frame(width: 328, height: 67, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .cornerRadius(10.0)
                                            .foregroundColor(Color("grayPeopleInLine"))
                                        HStack {
                                            Image("clock")
                                                .resizable()
                                                .frame(width: 25.6, height: 27.2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                                            Text(" \(time(timeString: (time2?.good)!)) - \(time(timeString: (time2?.bad)!))")
                                            Text("\(hour):\(minutes)")
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
                        }
                    }
                    }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Text("Status da Fila")
                                //.font(.title)
                )
                .navigationBarBackButtonHidden(true)
                .navigationBarColor(UIColor.white)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Sair da Fila"), message: Text("Você realmente gostaria de sair da fila?"), primaryButton: .default(Text("Sim")){
                        //lineplace?.invoked = true
                        handleRemoveFromLine()
                        currentLine = nil
                    }, secondaryButton: .default(Text("Não")))
                                        }
            }
                .onAppear(){
                    if(pushNotificationData.clientExitLine) {
                        currentLine = nil
                    }
                    handleDataFetch()
                    let date1 = Date().addingTimeInterval(TimeInterval(900))
                    hour = Calendar.current.component(.hour, from: date1)
                    minutes = Calendar.current.component(.minute, from: date1)
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
        //ClientLineStatusTab(currentLine: Binding.constant(BusinessModel(id: "1" ,email: "abc@gmail.com", name: "Teste", description: "Testeeeeeeeee", phone: "123456789", waitTime: 30.0, address: "Rua Dom Pedro, 888 - Porto Alegre", maxTableCapacity: 5, image: "Restaurante Azul")), lineplace: Binding.constant(LinePlaceModel(enterLine: "", exitLine: "", called: "", invoked: false, success: false, peopleInLine: 3, businessEmail: "", clientEmail: "")))
        ClientLineStatusTab(currentLine: Binding.constant(nil), lineplace: Binding.constant(LinePlaceModel(id: "2", enterLine: "", exitLine: "", called: "", invoked: true, success: false, peopleInLine: 3, businessEmail: "", clientEmail: "", clientName: "")), time2: Binding.constant(nil))
    }
}
