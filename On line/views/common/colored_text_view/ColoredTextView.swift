//
//  ColoredTextView.swift
//  On line
//
//  Created by Felipe Grosze Nipper de Oliveira on 11/05/21.
//

import SwiftUI

struct ColoredTextView: View {
    
    var text:String
    var body: some View {
        Text(text)
            .foregroundColor(Color("primary"))
    }
}

struct ColoredTextView_Previews: PreviewProvider {
    static var previews: some View {
        ColoredTextView(text: "Oi")
    }
}
