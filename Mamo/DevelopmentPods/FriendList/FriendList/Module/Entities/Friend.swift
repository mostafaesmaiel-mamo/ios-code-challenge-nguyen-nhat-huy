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
    let publicName: String
}

struct FriendFrequents: Equatable {
    let friends: [Friend]
}
