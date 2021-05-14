//
//  ButtonView2.swift
//  On line
//
//  Created by João Gabriel Biazus de Quevedo on 13/05/21.
//

import SwiftUI

struct ButtonView2: View {
    var text:String
    var action: () -> Void
    var body: some View {
        Button(action: action, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 22.0)
                    .frame(width: 210, height: 44, alignment: .center)
                    .foregroundColor(Color("primary"))
                Text(text)
                    .foregroundColor(Color.white)
                    .bold()
            }
        })
        
    }
}

struct ButtonView2_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView2(text: "entrar", action: {})
    }
}
