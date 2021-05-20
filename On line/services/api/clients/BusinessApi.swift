import Foundation
import Amplify

struct BusinessStatus: Codable {
    let isOpen: Bool
}

struct BusinessApi {
    let api = Api()
    
    //client
    func list(handler: @escaping ([BusinessModel]?) -> Void) {
        api.get(url: "/business") {
            business in handler(business)
        }
    }
    
    //business
    private func setIsOpen(isOpen: Bool, handler: @escaping (OpenCloseResponse?) -> Void) {
        //business email goes throught auth token.
        api.patch(url: "/business", data: BusinessStatus(isOpen: isOpen), handler: handler)
    }
    struct OpenCloseResponse:Codable {
        let success:Bool
    }
    //business
    func open(handler: @escaping (OpenCloseResponse?) -> Void) {
        //business email goes throught auth token.
        setIsOpen(isOpen: true) { business in handler(business) }
    }
    
    //business
    func close(handler: @escaping (OpenCloseResponse?) -> Void) {
        //business email goes throught auth token.
        setIsOpen(isOpen: false) { business in handler(business) }
    }
}
