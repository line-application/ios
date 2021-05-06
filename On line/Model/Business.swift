//
//  Business.swift
//  On line
//
//  Created by Diego Henrique on 06/05/21.
//

import Foundation

struct Business {
// ATTRIBUTES
    var name : String
    var email: String
    var waitTime: Double
    var isOpen: Bool
    var address: String
    var description: String
    var maxTableCapacity: Int
    var linePlaces: [LinePlace]
    
// FUNCTIONS
    func getName() -> String {}
    func getEmail() -> String {}
    func getWaitTime() -> Double {}
    func getAddress() -> String {}
    func getDescription() -> String {}
    func getMaxTableCapacity() -> Int {}
    func setData(name : String, email : String, phone: String, description: String, maxTableCapacity: Int, waitTime: Double) -> Bool {}
    func getLinePlaces() -> [LinePlace] {}
    func removeClientFromLine(clientEmail : String) -> Bool {}
    func setBusinessOpen() {}
    
}
