//
//  ImageButtonView.swift
//  On line
//
//  Created by Felipe Grosze Nipper de Oliveira on 11/05/21.
//

import SwiftUI

struct ImageButtonView: View {
    var action: () -> Void
    var body: some View {
        Button(action: action, label: {
            Image(systemName: "chevron.backward")
                .foregroundColor(Color.white)
        })
    }
}

struct ImageButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ImageButtonView {
            
        }
    }
}
