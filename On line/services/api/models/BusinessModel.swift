//
//  BusinessModel.swift
//  On line
//
//  Created by Artur Luis on 06/05/21.
//

import Foundation

struct BusinessModel: Codable {
    let email: Email?
    let name: String?
    let description: String?
    let phone: String?
    let waitTime: Double?
    let address: String?
    let maxTableCapacity: String?
}
