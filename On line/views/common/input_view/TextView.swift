//
//  TextView.swift
//  On line
//
//  Created by João Gabriel Biazus de Quevedo on 11/05/21.
//

import SwiftUI
import iPhoneNumberField

extension View {
    func underlineTextField(isWrong: Bool, input: String) -> some View {
        self
            .overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(isWrong && input == "" ? .red : Color("grayselector")))
            .foregroundColor(.black)
            .padding(5)
    }
}

struct TextView: View {
    @Binding var isWrong: Bool
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
                    if (label == "Telefone") {
                        iPhoneNumberField("", text: $input)
                            .maximumDigits(11)
                    }
                    else if (label == "E-mail") {
                        TextField("", text: $input)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                    }
                    else {
                        TextField("", text: $input)
                        .autocapitalization(.none)
                    }
                    
                }.underlineTextField(isWrong: isWrong, input: input)
            } else if isSecure == true {
                HStack{
                    SecureField("", text: $input)
                        .autocapitalization(.none)
                }.underlineTextField(isWrong: isWrong, input: input)
            }
        }.padding()
    }
}


//struct textview_Previews: PreviewProvider {
//    static var previews: some View {
//        textview()
//    }
//}
