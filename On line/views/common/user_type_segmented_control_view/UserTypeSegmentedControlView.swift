//
//  UserTypeSegmentedControllView.swift
//  On line
//
//  Created by Artur Luis on 13/05/21.
//

import SwiftUI

struct UserTypeSegmentedControlView: View {
    @EnvironmentObject var settings: SettingsState
    @Namespace var animation
    
    var body: some View {
        ZStack {
            ZStack{
                HStack (alignment: .center) {
                    Text("Cliente")
                        .foregroundColor(settings.userType == UserType.CLIENT ? .white : Color("primary"))
                        .padding(.vertical, 10)
                        .padding(.leading, 40)
                        .padding(.trailing, settings.userType == UserType.CLIENT ? 40 : 26)
                        .background(
                            ZStack{
                                if settings.userType == UserType.CLIENT{
                                    Color("primary")
                                        .cornerRadius(18)
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                }
                            }
                        )
                        .foregroundColor(settings.userType == UserType.CLIENT ? .black : .white)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                settings.userType = UserType.CLIENT
                            }
                        }
                    
                    Text("Estabelecimento")
                        .foregroundColor(settings.userType == UserType.BUSINESS ? .white : Color("primary"))
                        .padding(.vertical, 10)
                        .padding(.leading, settings.userType == UserType.BUSINESS ? 14 : 5.8)
                        .padding(.trailing, 12)
                        .background(
                            ZStack{
                                if settings.userType == UserType.BUSINESS{
                                    Color("primary")
                                        .cornerRadius(18)
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                }
                            }
                        )
                        .foregroundColor(settings.userType == UserType.BUSINESS ? .black : .white)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)){
                                settings.userType = UserType.BUSINESS
                            }
                        }
                }
                .background(Color.white)
                .cornerRadius(18)
            }
            .padding(.vertical, 1)
            .padding(.horizontal, 1)
            .background(Color("primary"))
            .cornerRadius(18)
        }
    }
}

struct UserTypeSegmentedControlView_Previews: PreviewProvider {
    static var previews: some View {
        UserTypeSegmentedControlView()
    }
}
