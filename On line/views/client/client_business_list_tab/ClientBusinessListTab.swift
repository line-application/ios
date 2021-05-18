//
//  ClientBusinessListTab.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct ClientBusinessListTab: View {
    @Binding var currentLine:BusinessModel?
    @State var list:[BusinessModel] = []
    @State var currentView: Bool = false
    @State var currentBusinessModel: BusinessModel = BusinessModel(id: "-23", email: "", name: "", description: "", phone: "", waitTime: 0.0, address: "", maxTableCapacity: 0, image: "")
    
    func fetchHandler(_ businessesResponse: [BusinessModel]?) {
        //print(businessesResponse)
        if let businesses = businessesResponse {
            list = businesses
            print(businesses)
        }
    }
    
    func fetchBusiness(){
        let businessApi = BusinessApi()
        businessApi.list{businesses in fetchHandler(businesses)}
    }
    
    var body: some View {
//        if(currentView){
//            RestaurantDetails(currentView: $currentView, bussinesModel: $currentBusinessModel )
//        }
//        else {
        NavigationView {
            VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 173, height: 51, alignment: .center)
                    Divider()
                    VStack {
                        ScrollView {
                            HStack {
                                Text("Olá ...")
                                    .foregroundColor(Color("primary"))
                                    .font(.system(size: CGFloat(29)))
                                Spacer()
                            }
                            .padding(.leading)
                            HStack {
                                Text("Onde você quer comer hoje?")
                                    .foregroundColor(Color("primary"))
                                Spacer()
                            }
                            .padding(.leading)
                            Text("")
                            HStack {
                                Text("Restaurantes com fila")
                                    .foregroundColor(Color("primary"))
                                    .font(.system(size: CGFloat(25)))
                                    .bold()
                                Spacer()
                            }
                            .padding(.leading)
                            ForEach(list) { business in
    //                            Button(action: {
    //                                currentView = true
    //                                currentBusinessModel = business
    //                            }, label: {
    //                                ClientCardView(bussinesModel: business)
    //                            })
                                NavigationLink(
                                    destination: RestaurantDetails(currentLine: $currentLine, bussinesModel: business ),
                                    label: {
                                        ClientCardView(bussinesModel: business)
                                    })
                            }
                        }//.padding(.bottom,83)
                    }
                }
                .padding(.top)
                .onAppear(){
                    fetchBusiness()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        }
    //}
}

struct ClientBusinessListTab_Previews: PreviewProvider {
    static var previews: some View {
        ClientBusinessListTab(currentLine: Binding.constant(BusinessModel(id: "1" ,email: "abc@gmail.com", name: "Teste", description: "Testeeeeeeeee", phone: "123456789", waitTime: 30.0, address: "Rua Dom Pedro, 888 - Porto Alegre", maxTableCapacity: 5, image: "Restaurante Azul")))
    }
}
