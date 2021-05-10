//
//  ButtonView.swift
//  On line
//
//  Created by Felipe Grosze Nipper de Oliveira on 10/05/21.
//

import SwiftUI

struct ButtonView: View {
    var text:String
    var action: () -> Void
    var body: some View {
        Button(action: action, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 22.0)
                    .frame(width: 129, height: 44, alignment: .center)
                    .foregroundColor(Color("primary"))
                Text(text)
                    .foregroundColor(Color.white)
            }
        })
        
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "entrar", action: {})
    }
}
