//
//  Stepper.swift
//  On line
//
//  Created by Diego Henrique on 10/05/21.
//

import SwiftUI
struct StepperView: View {
    @Binding var peoplePerTable : Int
    var body: some View {
        HStack {
            Text(peoplePerTable == 1 ? "\(peoplePerTable) pessoa" : "\(peoplePerTable) pessoas")
                .font(.custom("SFCompactDisplay-Regular", size: 16))
                .foregroundColor(Color(red: 106/255, green: 105/255, blue: 105/255))
                .padding(.leading, 20)
            Stepper("", value: $peoplePerTable, in: 1...1000)
                .padding(.trailing, 34)
        }
    }
}

//struct StepperView_Previews: PreviewProvider {
//    static var previews: some View {
//        StepperView(peoplePerTable: 1)
//    }
//}
