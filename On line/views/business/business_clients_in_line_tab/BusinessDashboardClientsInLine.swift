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
        linePlaceApi.list(invoked: false) {
            linePlacesResponse in
            if let linePlaces = linePlacesResponse{lineplacesList = linePlaces
                print(linePlaces)
            }
        }
    }
    
    func time(timeString:IsoString) -> Int {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"

        let updatedAtStr = timeString
        let updatedAt = dateFormatter.date(from: updatedAtStr) // "Jun 5, 2016, 4:56 PM"
        var inLinetime:Double = updatedAt?.distance(to: Date()) ?? 0
        inLinetime = inLinetime/60000
        return Int(inLinetime)
    }
    
    init() {
        
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
//                    BusinessLine(linePlaces: $lineplacesList, people: lineplace.peopleInLine, name: lineplace.clientName!, clientEmail: lineplace.clientEmail, time: time(timeString: lineplace.enterLine))
                    BusinessLine(lineplacesList: $lineplacesList, people: lineplace.peopleInLine, name: lineplace.clientName!, clientEmail: lineplace.clientEmail, time: time(timeString: lineplace.enterLine))
                }

            }
            Spacer()
        }
        .onAppear(){
            handleListLinePlace()
            print(lineplacesList.count)
        }
    }
}
struct BusinessClientsInLineTab_Previews: PreviewProvider {
    static var previews: some View {
        BusinessClientsInLineTab()
    }
}


