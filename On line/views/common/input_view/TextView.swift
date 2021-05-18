//
//  TextView.swift
//  On line
//
//  Created by João Gabriel Biazus de Quevedo on 11/05/21.
//

import SwiftUI

extension View {
    func underlineTextField(isWrong: Bool, input: String) -> some View {
        self
            .overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(isWrong && input == "" ? .red : Color("graySelector")))
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
        
        let binding = Binding<String>(get: {
                    if (self.input.count <= 14 && input.first == "(") || (self.input.count <= 10 && input.first != "(") {
                        return self.input.applyPatternOnNumbers(pattern: "(##) ####-####", replacementCharacter: "#")
                    } else {
                        return self.input.applyPatternOnNumbers(pattern: "(##) #####-####", replacementCharacter: "#")
                    }
                }, set: {
                    self.input = $0
                    // do whatever you want here
                })
        
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
                        TextField("", text: binding)
                            .keyboardType(.phonePad)
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

extension String {
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}

//struct textview_Previews: PreviewProvider {
//    static var previews: some View {
//        textview()
//    }
//}
