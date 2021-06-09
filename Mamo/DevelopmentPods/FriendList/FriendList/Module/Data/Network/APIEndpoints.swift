//
//  APIEndpoints.swift
//  FriendList
//
//  Created by Huy Nguyen on 08/06/2021.
//

import Foundation
import Networking

struct APIEndpoints {
    
    static func getListFrequents() -> Endpoint<FriendFrequentsDTO> {
        
        return Endpoint(path: "api/v2/frequents", method: .get)
    }
}
