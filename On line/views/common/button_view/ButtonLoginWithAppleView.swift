//
//  ButtonLoginWithAppleView.swift
//  On line
//
//  Created by Felipe Grosze Nipper de Oliveira on 26/05/21.
//

import SwiftUI

struct ButtonLoginWithAppleView: View {
    var width:CGFloat = CGFloat(260)
    var height:CGFloat = CGFloat(44)
    var backgroundColor: Color
    var text: String
    var textColor: Color
    var image: String = "Left White Logo Large"
    var action: () -> Void
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 150, style: .continuous)
                .frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(backgroundColor)
            Button(action: action, label: {
                HStack {
                    Image(image)
                        //.font(.body)
                        .resizable()
                        .scaledToFit()
                        .frame(height: height-2, alignment: .leading)
                    Text(text)
                        .font(.system(size: 17))
                }
                .offset(x:-10,y:0)
                
            })
            .frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(textColor)
        }
    }
}

//struct ButtonLoginWithAppleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonLoginWithAppleView()
//    }
//}
