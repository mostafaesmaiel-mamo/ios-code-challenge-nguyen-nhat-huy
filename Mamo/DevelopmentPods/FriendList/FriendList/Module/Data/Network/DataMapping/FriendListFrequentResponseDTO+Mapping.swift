//
//  FriendListFrequentResponseDTO+Mapping.swift
//  FriendList
//
//  Created by Huy Nguyen on 08/06/2021.
//

import Foundation

struct FriendFrequentsDTO: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case friends = "frequents"
    }
    
    let friends: [FriendDTO]
}

extension FriendFrequentsDTO {
    
    struct FriendDTO: Decodable {
        
        private enum CodingKeys: String, CodingKey {
            case id
            case publicName
        }
        
        let id: String
        let publicName: String
    }
}

extension FriendFrequentsDTO {
    func toDomain() -> FriendList {
        return .init(friends: friends.map{ $0.toDomain() } )
    }
}

extension FriendFrequentsDTO.FriendDTO {
    func toDomain() -> Friend {
        return .init(id: Friend.Identifier(id), key: "", value: "", publicName: publicName, isMamoOrFrequents: true, imageData: nil)
    }
}
