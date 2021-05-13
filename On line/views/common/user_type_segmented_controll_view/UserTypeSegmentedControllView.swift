//
//  UserTypeSegmentedControllView.swift
//  On line
//
//  Created by Artur Luis on 13/05/21.
//

import SwiftUI

struct UserTypeSegmentedControllView: View {
    @EnvironmentObject var settings: SettingsState
    @Namespace var animation
    
    var body: some View {
        ZStack {
            ZStack{
                HStack{
                    
                    Text("Cliente")
                        .foregroundColor(settings.userType == UserType.CLIENT ? .white : Color("primary"))
                        .padding(.vertical, 12)
                        .padding(.leading, 40)
                        .padding(.trailing, 40)
                        .background(
                            ZStack{
                                if settings.userType == UserType.CLIENT{
                                    Color("primary")
                                        .cornerRadius(30)
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
                        .padding(.vertical, 12)
                        .padding(.leading, 20)
                        .padding(.trailing, 14)
                        .background(
                            ZStack{
                                if settings.userType == UserType.BUSINESS{
                                    Color("primary")
                                        .cornerRadius(35)
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
                .cornerRadius(30)
            }
            .padding(.vertical, 3)
            .padding(.horizontal, 3)
            .background(Color("primary"))
            .cornerRadius(30)
        }
    }
}

struct UserTypeSegmentedControllView_Previews: PreviewProvider {
    static var previews: some View {
        UserTypeSegmentedControllView()
    }
}
