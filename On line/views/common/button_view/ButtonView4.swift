//
//  ButtonView4.swift
//  On line
//
//  Created by João Gabriel Biazus de Quevedo on 18/05/21.
//

import SwiftUI

struct ButtonView4: View {
    var text:String
    var action: () -> Void
    var body: some View {
        Button(action: action, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 22.0)
                    .frame(width: 129, height: 44, alignment: .center)
                    .foregroundColor(.green)
                Text(text)
                    .foregroundColor(Color.white)
                    .bold()
            }
        })
        
    }
}

struct ButtonView4_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView4(text: "CHAMAR", action: {})
    }
}
