//
//  LoginVIew.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(
                    destination: LoginClientRegister(),
                    label: {
                        Text("Login Client Register")
                    })
                NavigationLink(
                    destination: LoginBusinessRegister(),
                    label: {
                        Text("Login Business Register")
                    })
            }
            
        }
        
    }
}

struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
