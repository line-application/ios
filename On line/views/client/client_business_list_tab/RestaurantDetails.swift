//
//  RestaurantDetails.swift
//  On line
//
//  Created by João Gabriel Biazus de Quevedo on 13/05/21.
//

import SwiftUI

struct RestaurantDetails: View {
    @Binding var currentLine:BusinessModel?
    @Binding var lineplace:LinePlaceModel?
    @Binding var time2:TimeEstimativeModel?
    //@Binding var currentView: Bool
    @State var peoplePerTable: Int = 1
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var showAlert:Bool = false
    //@Binding
    var bussinesModel: BusinessModel
    @State var clientName:String = ""
    @State var clientEmail:String = ""
    
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
    
    func handleAddToLine() {
        let linePlaceApi = LinePlaceApi()
        linePlaceApi.create(linePlace: lineplace!, handler: {time in
            time2 = time
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
    }
    
//    func handleEnterinLine(lineplace:LinePlaceModel) {
//        let linePlaceApi = LinePlaceApi()
//        linePlaceApi.create(linePlace: lineplace) { timeEstimative in
//            print(timeEstimative)
//        }
//        
//    }
    
    var body: some View {
        VStack {
            Divider()
                .padding(.top,25)
            ScrollView {
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.white)
                        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15) ,radius: 5,x: 2, y: 4)
                        .frame(width: UIScreen.main.bounds.width*0.9, height: 600, alignment: .leading)
                        VStack(alignment: .leading){
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color(imageColor(colorImage: bussinesModel.image)))
                                    .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15) ,radius: 5,x: 2, y: 4)
                                    .frame(width: UIScreen.main.bounds.width*0.9, height: 107, alignment: .leading)
                                RoundedRectangle(cornerRadius: 0)
                                    .foregroundColor(Color(imageColor(colorImage: bussinesModel.image)))
                                    .frame(width: UIScreen.main.bounds.width*0.9, height: 87, alignment: .leading)
                                    .offset(x: 0, y: 10)
                                Image("\(bussinesModel.image)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 107, height: 107, alignment: .center)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                
                            }
                            VStack(alignment: .leading){
                                Text(bussinesModel.name)
                                    .foregroundColor(Color.black)
                                    .bold()
                                    .font(.title2)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                Text(bussinesModel.description)
                                    .foregroundColor(Color.black)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                HStack{
                                    Text("Endereço:")
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 20)
                                    Text("\(bussinesModel.address)")
                                        .foregroundColor(Color("primary"))
                                        .padding(.horizontal, 10)
                                }
                            }
                            HStack {
                                Text("Estimativa de espera")
                                    .padding(.horizontal, 20)
                                Image("clock")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 16, height: 17, alignment: .center)
                                Text("\(Int(bussinesModel.waitTime)) min")
                                    .foregroundColor(Color("primary"))
                                    .padding(10)
                            }
                            Text("Mesa para quantas pessoas?")
                                .padding(.vertical, 5)
                                .padding(.horizontal, 20)
                            StepperView(peoplePerTable: $peoplePerTable)
                                .padding(.top, 10)
                            Spacer()
                            HStack {
                                Spacer()
                                ButtonView2(text: "ENTRAR NA FILA", action: {
                                    self.mode.wrappedValue.dismiss()
                                    showAlert = true
                                    currentLine = bussinesModel
                                    let date = Date()

                                    let iso8601DateFormatter = ISO8601DateFormatter()
                                    iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                                    let string = iso8601DateFormatter.string(from: date)
                                    lineplace = LinePlaceModel(id: "\(Date().timeIntervalSince1970)", enterLine: string, exitLine: "", called: "", invoked: false, success: false, peopleInLine: peoplePerTable, businessEmail: bussinesModel.email, clientEmail: clientEmail, clientName: clientName)
                                })
                                Spacer()
                            }
                            Spacer()
                        }.frame(width: UIScreen.main.bounds.width*0.9, height: 600, alignment: .leading)
                        .alert(isPresented: $showAlert) {
                                                    Alert(
                                                        title: Text("Você entrou na fila!"),
                                                        message: Text("Para acompanhar seu progresso na fila acesse o Status da fila.")
                                                    )
                                                }
                }
            }
            .navigationTitle(Text("Restaurante"))
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
            //.padding(.top, 15)
        }
        .onAppear(){
            handleDataFetch()
        }
        }
    }


struct RestaurantDetails_Previews: PreviewProvider {
    //@State var oi:Bool = false
    static var previews: some View {
        RestaurantDetails(currentLine: Binding.constant(nil), lineplace: Binding.constant(LinePlaceModel(id: "1", enterLine: ",", exitLine: "", called: "", invoked: true, success: false, peopleInLine: 3, businessEmail: "", clientEmail: "", clientName: "")), time2: Binding.constant(nil), peoplePerTable: 2, bussinesModel: BusinessModel(id: "1" ,email: "abc@gmail.com", name: "Teste", description: "Testeeeeeeeee", phone: "123456789", waitTime: 30.0, address: "Rua Dom Pedro, 888 - Porto Alegre", maxTableCapacity: 5, image: "Restaurante Azul"))
//        RestaurantDetails(currentView: .constant(true), peoplePerTable: 2, bussinesModel: .constant(BusinessModel(id: "1" ,email: "abc@gmail.com", name: "Teste", description: "A petiskeira é uma das maiores redes de restaurantes de Porto Alegre. Uma marca familiar nascida em 1984, gaúcha e ícone da cidade quando o assunto é gastronomia rápida.", phone: "123456789", waitTime: 30.0, address: "Rua Dom Pedro, 888 - Porto Alegre", maxTableCapacity: 5, image: "Restaurante Azul")))
        
    }
}


