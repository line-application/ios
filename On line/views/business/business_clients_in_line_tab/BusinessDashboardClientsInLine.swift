//
//  BusinessDashboardClientsInLine.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct BusinessClientsInLineTab: View {
    @State var lineplacesList:[LinePlaceModel] = []
    
    func handleListLinePlace() {
        let linePlaceApi = LinePlaceApi()
        linePlaceApi.list(invoked: true) {
            linePlacesResponse in if let linePlaces = linePlacesResponse{lineplacesList = linePlaces}
        }
    }
    
    func time(timeString:IsoString) -> Int {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"

        let updatedAtStr = timeString
        let updatedAt = dateFormatter.date(from: updatedAtStr) // "Jun 5, 2016, 4:56 PM"
        var inLinetime:Double? = updatedAt?.distance(to: Date())
        return 0
    }
    
    init() {
        handleListLinePlace()
    }
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
                ForEach(lineplacesList){ lineplace in
                    BusinessLine(people: lineplace.peopleInLine, name: lineplace.clientName, time: time(timeString: lineplace.enterLine))
                }

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


