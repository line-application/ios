//
//  NavigationBarView.swift
//  On line
//
//  Created by Felipe Grosze Nipper de Oliveira on 11/05/21.
//

import SwiftUI

struct NavigationBarView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .size(CGSize(width: 1000.0, height: 80.0))
                .foregroundColor(Color("primary"))
            HStack{
                ImageButtonView {
                    
                }
                Spacer()
                Text("CADASTRO")
                    .foregroundColor(Color.white)
                Spacer()
        }
            .padding(.horizontal, 10.0)
            .padding(.top, -370.0)
            
        
    }
        .ignoresSafeArea()
}
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
    }
}
 
 
