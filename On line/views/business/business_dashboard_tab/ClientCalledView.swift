//
//  ClientsCalledView.swift
//  On line
//
//  Created by Diego Henrique on 14/05/21.
//

import SwiftUI

struct ClientCalledView: View {
    var clientName : String = ""
    var numberOfPeople: Int = 0
    
    var body: some View {
        HStack {
            Text("\(numberOfPeople)")
                .font(.system(size: 17))
                .bold()
                .foregroundColor(Color("primary"))
            Image("Clients")
                .resizable()
                .scaledToFit()
                .frame(width: 26, height: 20, alignment: .center)
            Text("\(clientName)")
                .font(.system(size: 17))
                .foregroundColor(Color("primary"))
                .multilineTextAlignment(.leading)
                .padding(.leading, 2.0)
                .frame(width: 200, alignment: .leading)
        }
   //     .padding(.trailing, 80.0)
    }
}

struct ClientCalledView_Previews: PreviewProvider {
    static var previews: some View {
        ClientCalledView(clientName: "Diego Henrique")
    }
}
