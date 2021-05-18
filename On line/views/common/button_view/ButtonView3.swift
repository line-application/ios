//
//  ButtonView3.swift
//  On line
//
//  Created by João Gabriel Biazus de Quevedo on 18/05/21.
//

import SwiftUI

struct ButtonView3: View {
    var text:String
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            ZStack{
                Text(text)
                    .frame(width: 115, height: 44, alignment: .center)
                    .foregroundColor(Color.red)
            }
        })
        
    }
}

struct ButtonView3_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView3(text: "Tirar da Fila", action: {})
    }
}
