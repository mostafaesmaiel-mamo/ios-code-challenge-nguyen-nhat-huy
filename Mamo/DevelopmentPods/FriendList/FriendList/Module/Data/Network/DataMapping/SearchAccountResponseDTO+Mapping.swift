//
//  SearchAccountResponseDTO+Mapping.swift
//  FriendList
//
//  Created by Huy Nguyen on 10/06/2021.
//

import Foundation

struct SearchAccountDTO: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case mamoAccounts
    }
    
    let mamoAccounts: [MamoAccountDTO]
}

extension SearchAccountDTO {
    
    struct MamoAccountDTO: Decodable {
        
        private enum CodingKeys: String, CodingKey {
            case id
            case key
            case value
            case publicName
        }
        
        let id: String
        let key: String
        let value: String
        let publicName: String?
    }
}

extension SearchAccountDTO {
    func toDomain() -> FriendList {
        return .init(friends: mamoAccounts.map { $0.toDomain() })
    }
}

extension SearchAccountDTO.MamoAccountDTO {
    func toDomain() -> Friend {
        return .init(id: Friend.Identifier(id), key: key, value: value, publicName: publicName ?? "", isMamoOrFrequents: false, imageData: nil)
    }
}
