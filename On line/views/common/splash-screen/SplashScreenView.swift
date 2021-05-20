//
//  SplashScreenView.swift
//  On line
//
//  Created by Diego Henrique on 20/05/21.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        Image("relogioRoxo")
            .resizable()
            .scaledToFit()
            .scaleEffect(animationAmount)
            .frame(width: 100, height: 110, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .animation(
                Animation.easeOut(duration: 0.9)
                            .repeatForever(autoreverses: true)
                    )
            .onAppear {
                self.animationAmount = 2
            }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
