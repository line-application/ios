//
//  RegisterView.swift
//  On line
//
//  Created by Artur Luis on 13/05/21.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var settings: SettingsState
    
    var body: some View {
        ZStack {
            VStack {
                Divider() .padding(.top, 10.0)
                UserTypeSegmentedControlView()
                    .padding()
                if settings.userType == UserType.CLIENT {
                    LoginClientRegister()
                }
                else if settings.userType == UserType.BUSINESS {
                    LoginBusinessRegister()
                }
            }
            .navigationTitle(Text("Cadastro"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            
        }
        .navigationBarColor(UIColor.white)
        .navigationBarItems(leading:
                                Button(action : {
                                    self.mode.wrappedValue.dismiss()
                                }){
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(Color("primary"))
                                })
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
