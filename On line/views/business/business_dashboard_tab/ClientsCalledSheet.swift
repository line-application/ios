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
    
    func handleRemoveFromLine() {
        let linePlaceApi = LinePlaceApi()
        linePlaceApi.remove(type: .AsBusiness, email: currentToDelete, handler: {_ in })
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
                List {
                    Section {
                        ForEach(clientsCalled) { item in
                            ClientCalledView(clientName: item.clientName!, numberOfPeople: item.peopleInLine)
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
                .navigationTitle("Clientes chamados")
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(InsetGroupedListStyle())
                .navigationBarItems(
                    leading: editButton
                )
                .environment(\.editMode, self.$editMode)
            }
            .navigationBarColor(UIColor.white)
        }
        .onAppear(){
            handleListLinePlace()
        }
        .onChange(of: clientsCalled, perform: { value in
            print(value.count)
//            for n in 0..<clientsCalled.count {
//            clientsCalled2.append(ClientCalled(clientName:clientsCalled2[n].clientName , peopleInLine: clientsCalled2[n].peopleInLine, clientEmail: clientsCalled2[n].clientEmail))
//            }
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
    
    private func deleteItems() {
        for id in selection {
            if let index = clientsCalled2.lastIndex(where: { $0.id == id }) {
                clientsCalled2.remove(at: index)
            }
        }
        selection = Set<UUID>()
    }
    
    func deleteItems(at offsets: IndexSet) {
        clientsCalled2.remove(atOffsets: offsets)
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
