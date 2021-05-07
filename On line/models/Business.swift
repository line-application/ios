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
    func getName() -> String {return ""}
    func getEmail() -> String {return ""}
    func getWaitTime() -> Double {return 0.0}
    func getAddress() -> String {return ""}
    func getDescription() -> String {return ""}
    func getMaxTableCapacity() -> Int {return 1}
    func setData(name : String, email : String, phone: String, description: String, maxTableCapacity: Int, waitTime: Double) -> Bool {return true}
    func getLinePlaces() -> [LinePlace] {return []}
    func removeClientFromLine(clientEmail : String) -> Bool {return true}
    func setBusinessOpen() {}
    
}
