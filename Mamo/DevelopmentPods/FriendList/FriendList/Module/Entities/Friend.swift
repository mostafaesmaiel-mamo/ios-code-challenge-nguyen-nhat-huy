//
//  Friend.swift
//  FriendList
//
//  Created by Huy Nguyen on 06/06/2021.
//

import Foundation

struct Friend: Equatable, Identifiable {
    typealias Identifier = String
    let id: Identifier
    let key: String?
    let value: String?
    let publicName: String
    let isMamoOrFrequents: Bool
    let imageData: Data?
}

struct FriendList: Equatable {
    let friends: [Friend]
}
