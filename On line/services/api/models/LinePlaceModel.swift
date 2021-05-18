//
//  LinePlaceModel.swift
//  On line
//
//  Created by Artur Luis on 06/05/21.
//

import Foundation


struct LinePlaceModel: Codable {
    let enterLine: IsoString?
    let exitLine: IsoString?
    let called: IsoString?
    var invoked: Bool?
    let success: Bool?
    let peopleInLine: Int?
    let businessEmail: Email?
    let clientEmail: Email?
}
