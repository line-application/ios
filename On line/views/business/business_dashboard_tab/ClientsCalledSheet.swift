//
//  ClientsCalledSheet.swift
//  On line
//
//  Created by Diego Henrique on 14/05/21.
//

import SwiftUI

struct ClientCalled: Identifiable {
    let clientName: String
    let peopleInLine: Int
    let clientEmail:String
    let id = UUID()
}

struct ClientsCalledSheet: View {
    @State var clientsCalled:[LinePlaceModel] = []
    @State private var clientsCalled2:[ClientCalled] = []
    @State var currentToDelete:String = ""
    var clientToDelete:LinePlaceModel = LinePlaceModel(id: "1", enterLine: ",", exitLine: "", called: "", invoked: true, success: false, peopleInLine: 3, businessEmail: "", clientEmail: "", clientName: "")
    
    func handleRemoveFromLine(email : String) {
        let linePlaceApi = LinePlaceApi()
        linePlaceApi.remove(type: .AsBusiness, email: email, handler: {_ in })
        print("Removido")
    }
    
    func handleListLinePlace() {
        let linePlaceApi = LinePlaceApi()
        linePlaceApi.list(invoked: true) {
            linePlacesResponse in if let linePlaces = linePlacesResponse{
                DispatchQueue.main.async {
                    clientsCalled = linePlaces
                    print(linePlaces)
                }
            }
        }
    }
    
    @State var editMode: EditMode = .active
    @State var selection = Set<UUID>()
    
    var body: some View {
        NavigationView {
            VStack {
                if clientsCalled.isEmpty {
                    ZStack{
                        Rectangle()
                            .frame(width: 328, height: 141, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .cornerRadius(10.0)
                            .foregroundColor(Color("grayPeopleInLine"))
                        VStack {
                            Text("Não há nenhum cliente\n na lista de chamados!")
                                .font(.system(size: 18))
                                .foregroundColor(Color("primary"))
                                .bold()
                            Text("Chame clientes da fila.")
                                .frame(width: 308, height: 50
                                       , alignment: .center)
                                .font(.system(size: 15))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("primary"))
                        }
                    }
                    .frame(width: 368, height: 141,alignment: .center)
                    .padding(39)
                    Spacer()
                    
                }
                else {
                    List {
                        Section {
                            ForEach(clientsCalled) { item in
                                ClientCalledView(clientName: item.clientName!, numberOfPeople: item.peopleInLine)
                            }
                            .onDelete(perform: deleteItems)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .navigationBarItems(
                        leading: editButton
                    )
                    .environment(\.editMode, self.$editMode)
                }
            }
            .navigationTitle("Clientes chamados")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(UIColor.white)
        }
        
        .onAppear(){
            handleListLinePlace()
        }
        .onChange(of: clientsCalled, perform: { value in
            print(value.count)
        })
        
    }
    
    private var editButton: some View {
        Button(action: {
            self.editMode.toggle()
            self.selection = Set<UUID>()
        }) {
            Text(self.editMode.title)
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        offsets.forEach { index in
            handleRemoveFromLine(email: clientsCalled[index].clientEmail)
        }
        clientsCalled.remove(atOffsets: offsets)
    }
}

extension EditMode {
    var title: String {
        self == .active ? "" : ""
    }
    
    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}

struct ClientsCalledSheet_Previews: PreviewProvider {
    static var previews: some View {
        ClientsCalledSheet()
    }
}
