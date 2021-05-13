//
//  Loader.swift
//  On line
//
//  Created by Artur Luis on 12/05/21.
//

import SwiftUI

struct LoaderView: View {
    @Binding var isLoading:Bool
    
    var body: some View {
        if(isLoading) { ProgressView() }
    }
}

struct Loader_Previews: PreviewProvider {
    struct LoaderWrapper: View {
        @State var isLoading:Bool = true
        var body: some View {
            LoaderView(isLoading: $isLoading)
        }
    }
    static var previews: some View {
        LoaderWrapper(isLoading: true)
    }
}
