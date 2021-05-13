//
//  RestaurantDetails.swift
//  On line
//
//  Created by João Gabriel Biazus de Quevedo on 13/05/21.
//

import SwiftUI

struct RestaurantDetails: View {
    
    @State var peoplePerTable: Int
    
    var bussinesModel: BusinessModel
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.white)
                .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15) ,radius: 5,x: 2, y: 4)
                .frame(width: UIScreen.main.bounds.width*0.9, height: 600, alignment: .leading)
                VStack(alignment: .leading){
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("orangeColor"))
                            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15) ,radius: 5,x: 2, y: 4)
                            .frame(width: UIScreen.main.bounds.width*0.9, height: 107, alignment: .leading)
                        RoundedRectangle(cornerRadius: 0)
                            .foregroundColor(Color("orangeColor"))
                            .frame(width: UIScreen.main.bounds.width*0.9, height: 87, alignment: .leading)
                            .offset(x: 0, y: 10)
                        Image("Restaurante Laranja")
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
                        ButtonView2(text: "ENTRAR NA FILA", action: {})
                        Spacer()
                    }
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width*0.9, height: 600, alignment: .leading)
            }
        }
    }


struct RestaurantDetails_Previews: PreviewProvider {
    static var previews: some View {
//        RestaurantDetails(peoplePerTable: 2, bussinesModel: BusinessModel(id: "1" ,email: "abc@gmail.com", name: "Teste", description: "Testeeeeeeeee", phone: "123456789", waitTime: 30.0, address: "Rua Dom Pedro, 888 - Porto Alegre", maxTableCapacity: 5, image: "Restaurante Azul"))
        RestaurantDetails(peoplePerTable: 2, bussinesModel: BusinessModel(id: "1" ,email: "abc@gmail.com", name: "Teste", description: "A petiskeira é uma das maiores redes de restaurantes de Porto Alegre. Uma marca familiar nascida em 1984, gaúcha e ícone da cidade quando o assunto é gastronomia rápida.", phone: "123456789", waitTime: 30.0, address: "Rua Dom Pedro, 888 - Porto Alegre", maxTableCapacity: 5, image: "Restaurante Azul"))
        
    }
}


