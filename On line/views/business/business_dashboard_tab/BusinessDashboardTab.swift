//
//  BusinessDashboardTab.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct BusinessDashboardTab: View {
    @EnvironmentObject var pushNotificationData: PushNotificationDataState
    @EnvironmentObject var settings: SettingsState
    @State var currentTab = "Off"
    @Namespace var animation
    @State var peoplePerTable = 1
    @State var showingSheet = false
    @State var businessName: String = ""
    @State var businessEmail: String = ""
    var peopleInLine: Int = 0
    @State var minPeoplePerTable: Int = 1000
    @State var lineplacesList:[LinePlaceModel] = []
    
    func handleListLinePlace() {
        let linePlaceApi = LinePlaceApi()
        linePlaceApi.list(invoked: false) {
            linePlacesResponse in if let linePlaces = linePlacesResponse{lineplacesList = linePlaces}
        }
    }
    
    func handleDataFetch() {
        //settings.isLoading = true
        Authentication.fetchAttributes() { attributes in
            DispatchQueue.main.async {
                if let unwrappedAttributes = attributes {
                    unwrappedAttributes.forEach { attribute in
                        switch attribute.key {
                        case .name:
                            businessName = attribute.value
                        case .email:
                            businessEmail = attribute.value
                        case .custom("isOpen"):
                            currentTab = attribute.value == "true" ? "On" : "Off"
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
    
        func handleCall(peopleToCall:Int){
            let linePlaceApi = LinePlaceApi()
            var clientEmail2 = ""
            for n in 0..<lineplacesList.count{
                if(lineplacesList[n].peopleInLine<=peopleToCall){
                    clientEmail2 = lineplacesList[n].clientEmail
                    break
                }
            }
            if clientEmail2 != "" {
                linePlaceApi.confirm(clientEmail: clientEmail2){response in print(response!) }
            }
        }
    
    func handleMinPeoplePerTable(){
        for n in 0..<lineplacesList.count{
            if(lineplacesList[n].peopleInLine<minPeoplePerTable){
                minPeoplePerTable = lineplacesList[n].peopleInLine
            }
        }
    }
    
    func handleOpen(){
        settings.isLoading = true
        let businessApi = BusinessApi()
        businessApi.open(handler: {_ in
            DispatchQueue.main.async {
                settings.isLoading = false
            }
        })
    }
    
    func handleClose(){
        settings.isLoading = true
        let businessApi = BusinessApi()
        businessApi.close(handler: {_ in
            DispatchQueue.main.async {
                settings.isLoading = false
            }
        })
    }
    
    
    var body: some View {
        ZStack {
            LoaderView()
            ZStack {
                VStack {
                    
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 129, height: 38, alignment: .center)
                    
                    Divider()
                    HStack() {
                        Text("Olá, \(businessName)!")
                            .font(.system(size: 19))
                            .foregroundColor(Color("primary"))
                            .bold()
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            .frame(width: 240, height: 75, alignment: .leading)
                        
                        Button(action: {showingSheet.toggle()}, label: {
                            Image("Clients Called")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 20, alignment: .center)
                                .padding(.leading, 33)
                        })
                    }
                    HStack {
                        Text("Você quer abrir a fila?")
                            .font(.system(size: 17))
                            .foregroundColor(Color("primary"))
                        
                        ZStack {
                            ZStack{
                                HStack (spacing: -7){
                                    Text("   Off   ")
                                        .font(.system(size: 13))
                                        .foregroundColor(Color("grayText"))
                                        .padding(.vertical, 6)
                                        .background(
                                            ZStack{
                                                if currentTab == "Off"{
                                                    Color("graySelector")
                                                        .cornerRadius(18)
                                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                                }
                                            }
                                        )
                                        .foregroundColor(currentTab == "Off" ? .black : .white)
                                        .onTapGesture {
                                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                                currentTab = "Off"
                                                handleClose()
                                            }
                                        }
                                    
                                    Text("    On   ")
                                        .font(.system(size: 13))
                                        .foregroundColor(currentTab == "On" ? .white : .gray)
                                        .padding(.vertical, 6)
                                        .background(
                                            ZStack{
                                                if currentTab == "On"{
                                                    Color("greenSelector")
                                                        .cornerRadius(18)
                                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                                }
                                            }
                                        )
                                        .foregroundColor(currentTab == "On" ? .black : .white)
                                        .onTapGesture {
                                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                                currentTab = "On"
                                                handleOpen()
                                            }
                                        }
                                }
                                .background(Color.white)
                                .cornerRadius(20)
                            }
                            .padding(.vertical, 1)
                            .padding(.horizontal, 1)
                            .background(Color("primary"))
                            .cornerRadius(18)
                        }
                        .padding()
                        .padding(.leading)
                    }
                    
                    Text(currentTab == "Off" ? "Fila fechada": lineplacesList.count == 0 ? "Nenhuma pessoa na fila" : lineplacesList.count == 1 ? "\(lineplacesList.count) pessoa na fila" : "\(lineplacesList.count) pessoas na fila")
                        .font(.system(size: 19))
                        .bold()
                        .opacity(currentTab == "Off" || lineplacesList.count == 0 || peoplePerTable > minPeoplePerTable ? 0.5 : 1)
                        .foregroundColor(Color("primary"))
                        .frame(width: 307, height: 72)
                        .background(Color("grayPeopleInLine"))
                        .cornerRadius(10)
                        .padding(35)
                    
                    Text("Capacidade de pessoas para mesa seguinte")
                        .font(.system(size: 16))
                        .foregroundColor(Color("primary"))
                        .frame(width: 354, height: 29)
                        .padding(.horizontal)
                        .padding(.bottom, -15)
                        .padding(.top, 10)
                    StepperView(peoplePerTable: $peoplePerTable)
                        .padding(35)
                        .padding(.top, -13.0)
                    
                    Button(action: {handleCall(peopleToCall: peoplePerTable)}, label: {
                        Text("CHAMAR O PRÓXIMO")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(width: 210, height: 44, alignment: .center)
                            .background(Color("primary"))
                            .opacity(currentTab == "Off"  ? 0.5 : 1)
                            .cornerRadius(22)
                        
                    })
                    .disabled(currentTab == "Off" || lineplacesList.count == 0 || peoplePerTable > minPeoplePerTable ? true : false)
                    .padding()
                    Text(currentTab == "On" && peoplePerTable > minPeoplePerTable && peopleInLine != 1 ? "Não há pessoas na fila que desejam no máximo \(peoplePerTable) lugares.\nO número mínimo de lugares desejado por algum cliente\n                                no momento é \(minPeoplePerTable)." : "")
                        .font(.system(size: 10))
                        .foregroundColor(.red)
                        .padding(.top, -15)
                    
                    Spacer()
                    
                }
                .padding(.top)
                .sheet(isPresented: $showingSheet) {
                    ClientsCalledSheet()
                }
            }
        }
        .onAppear(){
            handleDataFetch()
            handleListLinePlace()
        }.onChange(of: pushNotificationData.refetchClientList, perform: { value in
            let linePlaceApi = LinePlaceApi()
            linePlaceApi.list(invoked: false) {
                linePlacesResponse in if let linePlaces = linePlacesResponse{lineplacesList = linePlaces}
            }
        })
        .onChange(of: peoplePerTable, perform: { value in
            handleMinPeoplePerTable()
        })
            
    }
}

struct BusinessDashboardTab_Previews: PreviewProvider {
    static var previews: some View {
        BusinessDashboardTab(businessName: "Outback")
    }
}
