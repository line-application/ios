//
//  ClientsCalledSheet.swift
//  On line
//
//  Created by Diego Henrique on 14/05/21.
//

import SwiftUI

struct ClientCalled: Identifiable {
    let name: String
    let numberOfPeople: Int
    let id = UUID()
}

struct ClientsCalledSheet: View {
    @State private var clientsCalled = [
        ClientCalled(name: "Artur Luis", numberOfPeople: 2),
        ClientCalled(name: "Camila Gudolle", numberOfPeople: 3),
        ClientCalled(name: "Diego Henrique", numberOfPeople: 1),
        ClientCalled(name: "Felipe Nipper", numberOfPeople: 5),
        ClientCalled(name: "João Biazus", numberOfPeople: 4)
    ]
    
    @State var editMode: EditMode = .active
    @State var selection = Set<UUID>()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        ForEach(clientsCalled) { item in
                            ClientCalledView(clientName: item.name, numberOfPeople: item.numberOfPeople)
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
            if let index = clientsCalled.lastIndex(where: { $0.id == id }) {
                clientsCalled.remove(at: index)
            }
        }
        selection = Set<UUID>()
    }
    
    func deleteItems(at offsets: IndexSet) {
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
