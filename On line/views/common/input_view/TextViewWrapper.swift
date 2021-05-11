//
//  TextViewWrapper.swift
//  On line
//
//  Created by João Gabriel Biazus de Quevedo on 11/05/21.
//

import SwiftUI

struct TextViewWrapper: View {
    
    @State var email: String = ""
    @State var senha: String = ""
   
    
    var body: some View {
        VStack{
            textview(input: $email, label: "Email", isSecure: false)
            textview(input: $senha, label: "Senha", isSecure: true)
        }
        
    }
}

struct TextViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        TextViewWrapper()
    }
}
