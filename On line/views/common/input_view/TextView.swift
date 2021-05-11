//
//  TextView.swift
//  On line
//
//  Created by João Gabriel Biazus de Quevedo on 11/05/21.
//

import SwiftUI

extension View {
    func underlineTextField() -> some View {
        self
            .overlay(Rectangle().frame(height: 1).padding(.top, 35))
            .foregroundColor(.black)
            .padding(5)
    }
}

struct TextView: View {
    @Binding var input: String
    var label: String
    var isSecure: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(label)
                .foregroundColor(Color("primary"))
                .frame(width: 225, height: 29, alignment: .leading)
                .padding(.horizontal, 5)
                .padding(.bottom, -5)
                .padding(.top, -10)
            
            if isSecure == false {
                HStack{
                    TextField("", text: $input)
                        .autocapitalization(.none)
                }.underlineTextField()
            } else if isSecure == true {
                HStack{
                    SecureField("", text: $input)
                        .autocapitalization(.none)
                }.underlineTextField()
            }
        }.padding()
    }
}

//struct textview_Previews: PreviewProvider {
//    static var previews: some View {
//        textview()
//    }
//}
