//
//  ConnectionManager.swift
//  DataArtDemo
//
//  Created by Diego Quimbo on 28/6/21.
//

import UIKit
import Alamofire
import Reachability

class ConnectionManager {
    
    static let headers: HTTPHeaders = [
        .contentType("application/json"),
        .accept("application/json")
    ]
    
    class func hasConnectivity() -> Bool {
        do {
            let reachability: Reachability = try Reachability()
            let networkStatus = reachability.connection
            
            switch networkStatus {
            case .unavailable:
                return false
            case .wifi, .cellular:
                return true
            case .none:
                return false
            }
        }
        catch {
            return false
        }
    }
}
