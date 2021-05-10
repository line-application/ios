//
//  Stepper.swift
//  On line
//
//  Created by Diego Henrique on 10/05/21.
//

import SwiftUI
struct StepperView: View {
    @State private var people = 1
    var body: some View {
        HStack {
            Text(people == 1 ? "\(people) pessoa" : "\(people) pessoas")
                .font(.custom("SFCompactDisplay-Regular", size: 16))
                .foregroundColor(Color(red: 106/255, green: 105/255, blue: 105/255))
                .padding(.leading, 49)
            Stepper("", value: $people, in: 1...1000)
                .padding(.trailing, 54)
        }
    }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView()
    }
}
