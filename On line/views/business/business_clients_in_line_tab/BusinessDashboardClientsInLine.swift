//
//  BusinessDashboardClientsInLine.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct BusinessClientsInLineTab: View {
    var body: some View {
        VStack{
            Text("Fila")
                .font(.system(size: 20))
                .bold()
                .foregroundColor(Color("primary"))
                .padding(.vertical, 10)
            Divider()
            HStack{
                Text("Fila Geral")
                    .font(.system(size: 17))
                    .bold()
                    .foregroundColor(Color("primary"))
                    .padding(20)
                Spacer()
            }
            ScrollView{
                BusinessLine(people: 2, name: "João Gabriel", time: 30)
                BusinessLine(people: 2, name: "João Gabriel", time: 30)
            }
            Spacer()
        }
    }
}
struct BusinessClientsInLineTab_Previews: PreviewProvider {
    static var previews: some View {
        BusinessClientsInLineTab()
    }
}


