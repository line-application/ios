//
//  ClientCardView.swift
//  On line
//
//  Created by Felipe Grosze Nipper de Oliveira on 12/05/21.
//

import SwiftUI

struct ClientCardView: View {
    
    var bussinesModel: BusinessModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .frame(width: UIScreen.main.bounds.width*0.9, height: 107, alignment: .leading)
            HStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 107, height: 107, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .overlay(
                        Image(bussinesModel.image)
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(width: 107, height: 107, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    )
                
                VStack(alignment: .leading) {
                    Spacer()
                    Text(bussinesModel.name)
                        .foregroundColor(Color.black)
                        .bold()
                        .font(.title2)
                    Spacer()
                    Text("Estimativa de espera")
                    Spacer()
                    Text("\(Int(bussinesModel.waitTime)) min")
                        .foregroundColor(Color("primary"))
                    Spacer()
                }
                .padding(.leading,5)
            }
            .frame(width: UIScreen.main.bounds.width*0.9, height: 107, alignment: .leading)
        }
    }
}

struct ClientCardView_Previews: PreviewProvider {
    static var previews: some View {
        ClientCardView(bussinesModel: BusinessModel(email: "abc@gmail.com", name: "teste", description: "teste", phone: "123456789", waitTime: 30.0, address: "teste", maxTableCapacity: 5, image: "Restaurante Azul"))
        //ClientCardView()
    }
}
