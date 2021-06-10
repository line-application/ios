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
    
    func time(timeString:IsoString) -> Date {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoDateFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withDashSeparatorInDate,
            .withFractionalSeconds]
        let realDate = isoDateFormatter.date(from: timeString)!
        return realDate
    }
    
    init() {
        
    }
    var body: some View {
        NavigationView{
            VStack{
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
                        BusinessLine(lineplacesList: $lineplacesList, people: lineplace.peopleInLine, name: lineplace.clientName!, clientEmail: lineplace.clientEmail, time: time(timeString: lineplace.enterLine))
                    }
                    
                }
                Spacer()
            }
            .navigationTitle(Text("Fila"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarColor(UIColor.white)
            
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


