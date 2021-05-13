//
//  SettingsState.swift
//  On line
//
//  Created by Artur Luis on 12/05/21.
//

import Foundation

class SettingsState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var userType: UserType = UserType.CLIENT
    @Published var isLoading: Bool = false
}
