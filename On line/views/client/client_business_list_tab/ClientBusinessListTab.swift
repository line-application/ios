//
//  ClientBusinessListTab.swift
//  On line
//
//  Created by Artur Luis on 10/05/21.
//

import SwiftUI

struct ClientBusinessListTab: View {
    @State var list:[BusinessModel] = []
    
    init(){
        self.fetchBusiness()
    }
    
    func fetchHandler(_ businessesResponse: [BusinessModel]?) {
        if let businesses = businessesResponse {
            list = businesses
        }
    }
    
    func fetchBusiness(){
        let businessApi = BusinessApi()
        businessApi.list{businesses in print(businesses)}
    }
    
    var body: some View {   
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(list) { business in
                        ClientCardView(bussinesModel: business)
                    }
                }.padding(.bottom,83)
            }
        }
        
    }
}

struct ClientBusinessListTab_Previews: PreviewProvider {
    static var previews: some View {
        ClientBusinessListTab()
    }
}
