//
//  Loader.swift
//  On line
//
//  Created by Artur Luis on 12/05/21.
//

import SwiftUI

struct LoaderView: View {
    @EnvironmentObject var settings: SettingsState
    
    var body: some View {
        if(settings.isLoading) {
            VStack{
                Spacer()
                ProgressView()
                Spacer()
            }
        }
    }
}

struct Loader_Previews: PreviewProvider {
    struct LoaderWrapper: View {
        @State var isLoading:Bool = true
        var body: some View {
            LoaderView()
        }
    }
    static var previews: some View {
        LoaderWrapper(isLoading: true)
    }
}
