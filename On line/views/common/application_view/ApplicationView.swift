//
//  ApplicationView.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct ApplicationView: View {
    @State var isAuthenticated:Bool = true
    var userType:UserType = UserType.CLIENT
    
    var body: some View {
        if isAuthenticated {
            switch userType {
            case UserType.BUSINESS:
                BusinessView()
            case UserType.CLIENT:
                ClientView()
            }
        } else {
            LoginView()
        }
        
    }
}

struct ApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationView()
    }
}
